//
//  String.swift
//  Podcasted
//
//  Created by Ali Moussa on 10/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation

extension String {
    // https://stackoverflow.com/a/44755470
    func safeAddingPercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String? {
        // using a copy to workaround magic: https://stackoverflow.com/q/44754996/1033581
        let allowedCharacters = CharacterSet(bitmapRepresentation: allowedCharacters.bitmapRepresentation)
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    // https://stackoverflow.com/a/47112624
    var replacingHTMLEntities: String? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string
        } catch {
            return nil
        }
    }
}
