//
//  ChannelProvider.swift
//  NPOStream
//
//  Created by Bart den Hollander on 23/07/16.
//  Copyright © 2016 Bart den Hollander. All rights reserved.
//

import Foundation

public enum ChannelTitle: String {
    case NPO1 = "LI_NL1_4188102"
    case NPO2 = "LI_NL2_4188105"
    case NPO3 = "LI_NL3_4188107"
    case NPONieuws = "LI_NEDERLAND1_221673"
    case NPOPolitiek = "LI_NEDERLAND1_221675"
    case NPO101 = "LI_NEDERLAND3_221683"
    case NPOCultura = "LI_NEDERLAND2_221679"
    case NPOZappXtra = "LI_NEDERLAND3_221687"
    case NPORadio1 = "LI_RADIO1_300877"
    case NPORadio2 = "LI_RADIO2_300879"
    case NPO3FM = "LI_3FM_300881"
    case NPORadio4 = "LI_RA4_698901"
}

public class ChannelProvider {
    
    static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafePointer(to: &i) {
                $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
            }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
    
    public static var channelArray: [ChannelTitle] {
        get {
            var array: [ChannelTitle] = []
            for channel in self.iterateEnum(ChannelTitle) {
                array.append(channel)
            }
            return array
        }
    }
    
}
