//
//  NPOStream.swift
//  NPOStreamFramework
//
//  Created by Bart den Hollander on 28-01-16.
//  Copyright © 2016 Bart den Hollander. All rights reserved.
//

import Foundation
import UIKit

open class NPOStream {
    
    open static func getStream(_ channelTitle: ChannelTitle, onCompletion: @escaping (URL?, NSError?) -> Void) {
    
    DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
    
    guard let stream = ChannelProvider.streams[channelTitle] else {
        return onCompletion(nil, NSError(domain: "NPOStream error: ChannelTitle unknown", code: 999, userInfo: nil))
    }
    guard let streamURL = stream.url else {
        return onCompletion(nil, NSError(domain: "NPOStream error: Channel URL not available", code: 999, userInfo: nil))
    }
        
    let FirstURLtask = URLSession.shared.dataTask(with: URL(string: "http://ida.omroep.nl/npoplayer/i.js?s=\(streamURL)")!) { (data, response, error) in

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
                    newToken = newToken.setCharAt(firstPosition, character: second_digit)
                    newToken = newToken.setCharAt(secondPosition, character: first_digit)
                } else {
                    let first_character = newToken[12];
                    let second_character = newToken[13];
                    newToken = newToken.setCharAt(12, character: second_character)
                    newToken = newToken.setCharAt(13, character: first_character)
                }

                let supUrl = URL(string: "http://ida.omroep.nl/aapi/?type=jsonp&callback=?&stream=\(streamURL)&token=\(newToken)")
                
                let SecondURLtask = URLSession.shared.dataTask(with: supUrl! as URL) { (data, response, error) in
                    guard let rawStreamURLData = data else {
                        return onCompletion(nil, NSError(domain: "NPOStream error: Unwrapping 2st URL failed", code: 999, userInfo: nil))
                    }
                    guard let rawStreamURLString = String.init(data: rawStreamURLData, encoding: String.Encoding.utf8) else {
                        return onCompletion(nil, NSError(domain: "NPOStream error: Initialising 2st URL Data to string failed", code: 999, userInfo: nil))
                    }
                    let streamURLString = rawStreamURLString.subString(2, length: rawStreamURLString.characters.count - 1)
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
                        guard let url = URL(string: streamURL as! String) else {
                            return onCompletion(nil, NSError(domain: "NPOStream error: Initialising final URL from string failed", code: 999, userInfo: nil))
                        }
                        let ThirdURLtask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                            guard let finalStreamURL = data else {
                                return onCompletion(nil, NSError(domain: "NPOStream error: Unwrapping final URL failed", code: 999, userInfo: nil))
                            }
                            guard let response = String(data: finalStreamURL, encoding: String.Encoding.utf8) else {
                                return onCompletion(nil, NSError(domain: "NPOStream error: Parsing final URL data to string failed", code: 999, userInfo: nil))
                            }
                            guard let url:String = response.sliceFrom("setSource(\"", to: "\"") else {
                                return onCompletion(nil, NSError(domain: "NPOStream error: Unwrapping after string slicing failed", code: 999, userInfo: nil))
                            }
                            let finalUrl = URL(string: url.decodeJSONUri)
                            
                            DispatchQueue.main.async(execute: {
                                onCompletion(finalUrl, nil)
                            })
                        }
                        ThirdURLtask.resume()
                    }
                    catch {
                        return onCompletion(nil, NSError(domain: "NPOStream error: JSON Serialization failed with error: \(error)", code: 999, userInfo: nil))
                    }
                }
                SecondURLtask.resume()
            }
        }
        }
    FirstURLtask.resume()
    }
    }
    
}
