//
//  Date+Format.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.05.2023.
//

import Foundation

enum DateFormat: String {
    case yyyyMMddTHHmmssSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case hhmm = "HH:mm"
    case hhmmss = "HH:mm:ss"
    case yyMM = "yyMM"
    case yyyy = "yyyy"
    case ddMMyy = "dd.MM.yy"
    case ddMMyyyy = "dd.MM.yyyy"
    case ddMMyyyyHHmm = "dd.MM.yyyy HH:mm"
    case ddMMyyyyCommaHHmm = "dd.MM.yyyy, HH:mm"
    case ddMMyyyyHHmmss = "dd.MM.yyyy HH:mm:ss"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case ddMMyyyyE = "dd.MM.yyyy, E"
    case yyyyMMdd = "yyyy-MM-dd"
    case dMMMMyyyy = "d MMMM yyyy"
    case dMMMMHHmm = "d MMMM, HH:mm"
    case dMMyyyyHHmm = "d.MM.yyyy, HH:mm"
    case MMyyyy = "MM.yyyy"
    case MMMMyyyy = "MMMM yyyy"
    case MMMMCommayyyy = "MMMM, yyyy"
    case ddMMMMCommayyyy = "dd MMMM, yyyy"
    case yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case ddMMMyyyyHHmm = "dd MMM yyyy, HH:mm"
    case MM = "MM"
    case dMMMM = "d MMMM"
    
    var value: String {
        return self.rawValue
    }
}

extension Date {
    func toString(format: DateFormat, locale: String? = nil, timeZone: TimeZone? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.value
        dateFormatter.locale = Locale(identifier: "kz")
        dateFormatter.timeZone = timeZone
        
        return dateFormatter.string(from: self)
    }
    
    func timeElapsedString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        formatter.calendar?.locale = Locale(identifier: "kz")
        
        guard let timeString = formatter.string(from: self, to: Date()) else {
            return ""
        }
        
        return "\(timeString) ago"
    }
}
