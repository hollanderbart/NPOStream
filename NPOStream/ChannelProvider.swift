//
//  ChannelProvider.swift
//  NPOStream
//
//  Created by Bart den Hollander on 23/07/16.
//  Copyright © 2016 Bart den Hollander. All rights reserved.
//

import Foundation

public enum ChannelTitle: String {
    case NPO1 = "NPO 1"
    case NPO2 = "NPO 2"
    case NPO3 = "NPO 3"
    case NPONieuws = "NPO Nieuws"
    case NPOPolitiek = "NPO Politiek"
    case NPOBest = "NPO Best"
    case NPODoc = "NPO Doc"
    case NPO101 = "NPO 101"
    case NPOCultura = "NPO Cultura"
    case NPOZappXtra = "NPO Zapp Xtra"
    case NPOHumor = "NPO Humor TV"
}

public class ChannelProvider {
    
    static let streams:[ChannelTitle:Channel] = [
        ChannelTitle.NPO1:Channel(
            title: ChannelTitle.NPO1.rawValue,
            url: URL(type: .Live, name: "ned1")),
        ChannelTitle.NPO2:Channel(
            title: ChannelTitle.NPO2.rawValue,
            url: URL(type: .Live, name: "ned2")),
        ChannelTitle.NPO3:Channel(
            title: ChannelTitle.NPO3.rawValue,
            url: URL(type: .Live, name: "ned3")),
        ChannelTitle.NPONieuws:Channel(
            title: ChannelTitle.NPONieuws.rawValue,
            url: URL(type: .Thema, name: "journaal24")),
        ChannelTitle.NPOPolitiek:Channel(
            title: ChannelTitle.NPOPolitiek.rawValue,
            url: URL(type: .Thema, name: "politiek24")),
        ChannelTitle.NPOBest:Channel(
            title: ChannelTitle.NPOBest.rawValue,
            url: URL(type: .Thema, name: "best24")),
        ChannelTitle.NPODoc:Channel(
            title: ChannelTitle.NPODoc.rawValue,
            url: URL(type: .Thema, name: "hollanddoc24")),
        ChannelTitle.NPO101:Channel(
            title: ChannelTitle.NPO101.rawValue,
            url: URL(type: .Thema, name: "101tv")),
        ChannelTitle.NPOCultura:Channel(
            title: ChannelTitle.NPOCultura.rawValue,
            url: URL(type: .Thema, name: "cultura24")),
        ChannelTitle.NPOZappXtra:Channel(
            title: ChannelTitle.NPOZappXtra.rawValue,
            url: URL(type: .Thema, name: "zappelin24")),
        ChannelTitle.NPOHumor:Channel(
            title: ChannelTitle.NPOHumor.rawValue,
            url: URL(type: .Thema, name: "humor24"))
    ]
    
}
