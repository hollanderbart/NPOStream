//
//  URL+Extension.swift
//  NPOStream
//
//  Created by Bart den Hollander on 23/07/16.
//  Copyright © 2016 Bart den Hollander. All rights reserved.
//

import Foundation

private let _baseURL = "http://livestreams.omroep.nl/live/npo/"

extension URL {
    
    init?(type: ChannelType, name: String) {
        // Example: http://livestreams.omroep.nl/live/npo/tvlive/ned1/ned1.isml/ned1.m3u8
        // baseURL: http://livestreams.omroep.nl/live/npo/
        // type: .Live (rawValue: "tvlive")
        // name: ned1
        let urlString = "\(_baseURL)\(type.rawValue)/\(name)/\(name).isml/\(name).m3u8"
        self.init(string: urlString)
    }
}
