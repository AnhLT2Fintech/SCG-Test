//
//  String+Extension.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import Foundation

extension String {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "MMM d, h:mm a"
            formatter.locale = Locale(identifier: "en_US")
            return formatter.string(from: date)
        }
        return ""
    }
}
