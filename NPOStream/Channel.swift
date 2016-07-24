//
//  Channel.swift
//  NPOStream
//
//  Created by Bart den Hollander on 23/07/16.
//  Copyright © 2016 Bart den Hollander. All rights reserved.
//

import Foundation

enum ChannelType: String {
    case Live = "tvlive"
    case Thema = "thematv"
}

class Channel {
    var title: String
    var url: URL?
    
    init(title: String, url: URL?) {
        self.title = title
        self.url = url
    }
}
