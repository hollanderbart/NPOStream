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
    
    open static func getStream(_ channelTitle: ChannelStreamTitle, onCompletion: @escaping (URL?, NSError?) -> Void) {
    
    let API_URL = "http://ida.omroep.nl/app.php/"
    let TOKEN_URL = "http://ida.omroep.nl/app.php/auth"
        
    DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {

    let FirstURLtask = URLSession.shared.dataTask(with: URL(string: TOKEN_URL)!) { (data, response, error) in

        if let data = data {
            if let response = String(data: data, encoding: String.Encoding.utf8) {
                guard let token:String = response.sliceFrom("token\":\"", to: "\"") else {
                    return onCompletion(nil, NSError(domain: "NPOStream error: Unwrapping after string slicing failed", code: 999, userInfo: nil))
                }
                let supUrl = URL(string: API_URL + channelTitle.rawValue + "?adaptive=yes&token=" + token)
                
                let SecondURLtask = URLSession.shared.dataTask(with: supUrl!) { (data, response, error) in
                    guard let rawStreamURLData = data else {
                        return onCompletion(nil, NSError(domain: "NPOStream error: Unwrapping 2st URL failed", code: 999, userInfo: nil))
                    }
                    guard let rawStreamURLString = String.init(data: rawStreamURLData, encoding: String.Encoding.utf8) else {
                        return onCompletion(nil, NSError(domain: "NPOStream error: Initialising 2st URL Data to string failed", code: 999, userInfo: nil))
                    }
                    guard let url:String = rawStreamURLString.sliceFrom("url\":\"", to: "\",\"") else {
                        return onCompletion(nil, NSError(domain: "NPOStream error: Unwrapping after string slicing failed", code: 999, userInfo: nil))
                    }
                    let streamURLString = url.decodeJSONUri
                    
                    guard let finalURL = URL(string: streamURLString) else {
                        return onCompletion(nil, NSError(domain: "NPOStream error: Initialising final URL from string failed", code: 999, userInfo: nil))
                    }
                    
                    let ThirdURLtask = URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
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
                SecondURLtask.resume()
            }
        }
        }
    FirstURLtask.resume()
    }
    }
    
}
