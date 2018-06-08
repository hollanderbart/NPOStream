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

    public static func getStreamURL(for channelTitle: ChannelStreamTitle, _ onCompletion: @escaping (Result<URL>) -> Void) {

        let API_URL = "http://ida.omroep.nl/app.php/"
        let TOKEN_URL = URL(string: "http://ida.omroep.nl/app.php/auth")!

        DispatchQueue.global(qos: .userInteractive).async {
            let authenticateURLSession = URLSession.shared.dataTask(with: TOKEN_URL) { (data, response, error) in

                guard
                    let data = data,
                    let auth = try? data.decoded() as Auth else {
                        DispatchQueue.main.async {
                            onCompletion(.error(NPOStreamError.parsingAuthenticateURLFailed))
                        }
                        return
                }
                guard var channelURLComponents = URLComponents(string: API_URL + channelTitle.rawValue) else { return }
                let channelURLQueryItems = [URLQueryItem(name: "adaptive", value: "yes"),
                                            URLQueryItem(name: "token", value: auth.token)]
                channelURLComponents.queryItems = channelURLQueryItems
                guard let channelURL = channelURLComponents.url else { return }
                let channelURLSession = URLSession.shared.dataTask(with: channelURL) { (data, response, error) in
                    guard
                        let data = data,
                        let channelRequest = try? data.decoded() as ChannelRequest,
                        let channelRequestURL = channelRequest.items.first?.first?.url else {
                            DispatchQueue.main.async {
                                onCompletion(.error(NPOStreamError.parsingChannelURLFailed))
                            }
                            return
                        }

                        let channelSourceURLSession = URLSession.shared.dataTask(with: channelRequestURL) { (data, response, error) in
                        guard
                            let data = data,
                            let response = String(data: data, encoding: .utf8),
                            let urlString = response.sliceFrom("setSource(\"", to: "\"")?.replacingOccurrences(of: "\\/", with: "/"),
                            let resultURL = URL(string: urlString) else {
                                DispatchQueue.main.async {
                                    onCompletion(.error(NPOStreamError.channelSourceURLFailed))
                                }
                                return
                        }
                        
                        DispatchQueue.main.async {
                            onCompletion(.success(resultURL))
                        }
                    }
                    channelSourceURLSession.resume()
                }
                channelURLSession.resume()
            }
            authenticateURLSession.resume()
        }
    }
}
