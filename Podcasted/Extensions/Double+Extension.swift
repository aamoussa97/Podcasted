//
//  Double.swift
//  Podcasted
//
//  Created by Ali Moussa on 01/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation

extension Double {

    func truncate(to places: Int) -> Double {
        return Double(Int((pow(10, Double(places)) * self).rounded())) / pow(10, Double(places))
    }
    
    // https://stackoverflow.com/a/48371292
    func stringFromInterval() -> String {
        let timeInterval = Int(self)

        let millisecondsInt = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let secondsInt = timeInterval % 60
        let minutesInt = (timeInterval / 60) % 60
        let hoursInt = (timeInterval / 3600) % 24
        let daysInt = timeInterval / 86400

        let milliseconds = "\(millisecondsInt)ms"
        let seconds = "\(secondsInt)s" + " " + milliseconds
        let minutes = "\(minutesInt)m" + " " + seconds
        let hours = "\(hoursInt)h" + " " + minutes
        let days = "\(daysInt)d" + " " + hours

        if daysInt          > 0 { return days }
        if hoursInt         > 0 { return hours }
        if minutesInt       > 0 { return minutes }
        if secondsInt       > 0 { return seconds }
        if millisecondsInt  > 0 { return milliseconds }
        return ""
    }

}
