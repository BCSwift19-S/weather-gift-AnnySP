//
//  TimeInterval+format.swift
//  Weather Gift
//
//  Created by Anny Shan on 3/25/19.
//

import Foundation

extension TimeInterval {
    func format(timeZone: String, dateFormatter: DateFormatter) -> String {
        let usableDate = Date(timeIntervalSince1970: self)
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usableDate)
        return dateString
    }
}
