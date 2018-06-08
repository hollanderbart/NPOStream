//
//  NPOStreamError.swift
//  NPOStream
//
//  Created by Bart den Hollander on 26/09/2017.
//  Copyright © 2017 Bart den Hollander. All rights reserved.
//

import Foundation

public enum NPOStreamError: String, Error, LocalizedError {
    case parsingAuthenticateURLFailed
    case parsingChannelURLFailed
    case channelSourceURLFailed

    public var errorDescription: String? {
        return self.rawValue
    }
}
