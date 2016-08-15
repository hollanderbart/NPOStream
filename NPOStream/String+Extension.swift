//
//  String+Extension.swift
//  NPOStream
//
//  Created by Bart den Hollander on 21-11-15.
//  Copyright © 2016 Bart den Hollander. All rights reserved.
//

import Foundation

extension String {
    
	func sliceFrom(_ start: String, to: String) -> String? {
		return (range(of: start)?.upperBound)
            .flatMap { sInd in
			(range(of: to, range: sInd ..< endIndex)?.lowerBound)
                .map { eInd in
				substring(with: sInd ..< eInd)
			}
		}
	}
	
    var encodeURIComponent: String? {
		return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
	}
	
    var decodeJSONUri: String {
		return self.replacingOccurrences(of: "\\/", with: "/")
	}
	
	subscript (i: Int) -> Character {
		get {
			let index = characters.index(startIndex, offsetBy: i)
			return self[index]
		}
	}
	
	func setCharAt(_ index: Int, character: Character) -> String {
		if index > self.characters.count - 1 {
			return self
		}
		
		return self.subString(0, length: index) + String(character) + self.subString(index + 1, length: self.characters.count)
	}
	
	public func subString(_ startIndex: Int, length: Int) -> String {
        let start = self.characters.index(self.startIndex, offsetBy: startIndex)
        let end = self.characters.index(self.startIndex, offsetBy: length)
        return self.substring(with: Range<String.Index>(start ..< end))
	}
    
    func htmlDecoded() -> String {
        guard (self != "") else { return self }
        var newStr = self
        let entities = [
            "&quot;"    : "\"",
            "&amp;"     : "&",
            "&apos;"    : "'",
            "&lt;"      : "<",
            "&gt;"      : ">",
        ]
        
        for (name,value) in entities {
            newStr = newStr.replacingOccurrences(of: name, with: value)
        }
        return newStr
    }
}
