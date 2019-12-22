//
//  Int.swift
//  Podcasted
//
//  Created by Ali Moussa on 13/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation

extension Int {
    func formatMSToDate(miliseconds: Int) -> String {
        let milisecond = miliseconds
        let dateVar = Date.init(timeIntervalSince1970: TimeInterval(milisecond)/1000)
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var dateFormatterString = dateFormatter.string(from: dateVar)
        
        return dateFormatterString
    }
}
