//
//  ChannelRequest.swift
//  NPOStream
//
//  Created by Bart den Hollander on 08/06/2018.
//  Copyright © 2018 Bart den Hollander. All rights reserved.
//

import Foundation

struct ChannelRequest: Codable {

    let limited: Bool
    let site: Bool?
    let items: [[ChannelRequestItem]]
}

struct ChannelRequestItem: Codable {

    let label: String
    let contentType: String
    let url: URL
    let format: String
}
