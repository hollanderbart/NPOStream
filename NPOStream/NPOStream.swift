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

    public static func getStream(url: String, onCompletion: (URL?, NSError?) -> Void) {
    
    DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosUserInitiated).async {

    let task = URLSession.shared.dataTask(with: NSURL(string: "http://ida.omroep.nl/npoplayer/i.js?s=\(url)")! as URL) { (data, response, error) in

        if let data = data {
            if let response = String(data: data, encoding: String.Encoding.utf8) {
                var newToken = response.components(separatedBy: "\"")[1]
                
                var firstPosition = 0, secondPosition = 0
                
                for i in 5 ..< (newToken.characters.count - 5) {
                    for j in 0...9 {
                        if (newToken[i] == Character.init(String(j))) {
                            if(firstPosition == 0) {
                                firstPosition = i
                            } else if (secondPosition == 0) {
                                secondPosition = i
                                break
                            }
                        }
                    }
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
                    guard let rawStreamURLData = data else {
                        return onCompletion(nil, NSError(domain: "NPOStream error: Unwrapping 2st URL failed", code: 999, userInfo: nil))
                    }
                    guard let rawStreamURLString = String.init(data: rawStreamURLData, encoding: String.Encoding.utf8) else {
                        return onCompletion(nil, NSError(domain: "NPOStream error: Initialising 2st URL Data to string failed", code: 999, userInfo: nil))
                    }
                    let streamURLString = rawStreamURLString.subString(startIndex: 2, length: rawStreamURLString.characters.count - 1)
                    guard let streamURLStringData = streamURLString.data(using: String.Encoding.utf8) else {
                        return onCompletion(nil, NSError(domain: "NPOStream error: Converting string to data failed", code: 999, userInfo: nil))
                    }
                    do {
                        let rawStreamURLJSON = try JSONSerialization.jsonObject(
                            with: streamURLStringData,
                            options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:AnyObject]
                        guard let streamURL = rawStreamURLJSON["stream"] else {
                            return onCompletion(nil, NSError(domain: "NPOStream error: Get stream URL from JSON failed", code: 999, userInfo: nil))
                        }
                        guard let url = URL.init(string: String(streamURL)) else {
                            return onCompletion(nil, NSError(domain: "NPOStream error: Initialising final URL from string failed", code: 999, userInfo: nil))
                        }
                        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                            guard let finalStreamURL = data else {
                                return onCompletion(nil, NSError(domain: "NPOStream error: Unwrapping final URL failed", code: 999, userInfo: nil))
                            }
                            guard let response = String(data: finalStreamURL, encoding: String.Encoding.utf8) else {
                                return onCompletion(nil, NSError(domain: "NPOStream error: Parsing final URL data to string failed", code: 999, userInfo: nil))
                            }
                            guard let url:String = response.sliceFrom(start: "setSource(\"", to: "\"") else {
                                return onCompletion(nil, NSError(domain: "NPOStream error: Unwrapping after string slicing failed", code: 999, userInfo: nil))
                            }
                            let finalUrl = URL(string: url.decodeJSONUri)
                            
                            DispatchQueue.main.async(execute: {
                                onCompletion(finalUrl, nil)
                            })
                        }
                        task.resume()
                    }
                    catch {
                        return onCompletion(nil, NSError(domain: "NPOStream error: JSON Serialization failed with error: \(error)", code: 999, userInfo: nil))
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
