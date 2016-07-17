//
//  NPOStream.swift
//  NPOStreamFramework
//
//  Created by Bart den Hollander on 28-01-16.
//  Copyright © 2016 Bart den Hollander. All rights reserved.
//

import Foundation
import UIKit

public class NPOStream {

    public static func getStream(url: String, onCompletion: (URL) -> Void) {
    
    DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosUserInitiated).async {

    let task = URLSession.shared.dataTask(with: NSURL(string: "http://ida.omroep.nl/npoplayer/i.js?s=\(url)")! as URL) { (data, response, error) in

        if let data = data {
            if let response = NSString(data: data, encoding: String.Encoding.utf8.rawValue) where response.contains("\"") {
                let token = response.components(separatedBy: "\"")
                var newToken = token[1]
                
                if newToken != "" {
                    
                    var firstPosition = 0
                    var secondPosition = 0
                    
                    for i in 5 ..< (newToken.characters.count - 5) {

                        for j in 0...9 {
                            if (newToken[i] == Character(UnicodeScalar(j))) {
                                if(firstPosition == 0) {
                                    firstPosition = i
                                } else if (secondPosition == 0) {
                                    secondPosition = i
                                    break
                                }
                            }
                        }
                        
//                        let nul:Character = "0"
//                        let een:Character = "1"
//                        let twee:Character = "2"
//                        let drie:Character = "3"
//                        let vier:Character = "4"
//                        let vijf:Character = "5"
//                        let zes:Character = "6"
//                        let zeven:Character = "7"
//                        let acht:Character = "8"
//                        let negen:Character = "9"
//                        
//                        if (newToken[i] == nul || newToken[i] == een || newToken[i] == twee || newToken[i] == drie || newToken[i] == vier || newToken[i] == vijf || newToken[i] == zes || newToken[i] == zeven || newToken[i] == acht || newToken[i] == negen) {
//                            
//                            if(firstPosition == 0) {
//                                firstPosition = i
//                            } else if (secondPosition == 0) {
//                                secondPosition = i
//                                break
//                            }
//                        }
                    }

                if(secondPosition != 0){
                    let first_digit = newToken[firstPosition];
                    let second_digit = newToken[secondPosition];
                    newToken = newToken.setCharAt(index: firstPosition, character: second_digit)
                    newToken = newToken.setCharAt(index: secondPosition, character: first_digit)
                } else {
                    let first_character = newToken[12];
                    let second_character = newToken[13];
                    newToken = newToken.setCharAt(index: 12, character: second_character)
                    newToken = newToken.setCharAt(index: 13, character: first_character)
                }

                let supUrl = NSURL(string: "http://ida.omroep.nl/aapi/?type=jsonp&callback=?&stream=\(url)&token=\(newToken)")

                let task = URLSession.shared.dataTask(with: supUrl! as URL) { (data, response, error) in
                    
                    if let data = data {

                        if let response = NSString(data: data, encoding: String.Encoding.utf8.rawValue) where response.contains("stream\":\"") {
                        let url = response.components(separatedBy: "stream\":\"")
                        let url2 = url[1].components(separatedBy: "\"")
                            
                        let task = URLSession.shared.dataTask(with: NSURL(string: "\(url2[0].decodeJSONUri)")! as URL) { (data, response, error) in
                            
                                if let data = data {
                                    
                                    if let response = NSString(data: data, encoding: String.Encoding.utf8.rawValue) where response.contains("setSource(\"") {
                                    let url = response.components(separatedBy: "setSource(\"")
                                    let url2 = url[1].components(separatedBy: "\"")
                                    let finalUrl = URL(string: url2[0].decodeJSONUri)
                                    
                                    DispatchQueue.main.async(execute: {
                                        onCompletion(finalUrl!)
                                    })
                                    }
                                }
                            }
                            task.resume()
                        }
                    }
                }
                task.resume()
                }
            }
        }
        }
    task.resume()
    }
    }
    
}
