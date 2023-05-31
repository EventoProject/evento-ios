//
//  String+Extensions.swift
//  Evento
//
//  Created by Ramir Amrayev on 28.05.2023.
//

import Foundation

extension String {
    func toDate(with format: DateFormat, locale: String = "kz") -> Date? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = format.value
        dateFormatterGet.locale = Locale(identifier: locale)
        return dateFormatterGet.date(from: self)
    }
}
