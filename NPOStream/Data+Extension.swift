//
//  Data+Extension.swift
//  NPOStream
//
//  Created by Bart den Hollander on 07/06/2018.
//  Copyright © 2018 Bart den Hollander. All rights reserved.
//

import Foundation

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
