//
//  DateHelper.swift
//  StarterPack
//
//  Created by Insight Workshop on 12/12/18.
//  Copyright © 2018 Insight Workshop. All rights reserved.
//

import Foundation

class DateHelper: NSObject {
    
    let calendar: Calendar
    var dateFormatter: DateFormatter
    
    static let shared: DateHelper = {
        
        return DateHelper()
        
    }()
    
    override init() {
        
        calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        
        super.init()
        
    }
    
    
    
}

extension DateHelper {
    
    func getTodayDate(withFormat: String = "yyyy-MM-dd") -> String {
        return DateHelper.shared.getStringDate(Date(), havingFormat: withFormat)
    }
    
    func getTodayDate() -> Date {
        return Date()
    }
}

// MARK: - String date to Date object formatters
extension DateHelper {
    
    func getDateFrom(dateString: String, havingFormat: String, isUTC: Bool = false) -> Date? {
        
        if dateString.isEmpty {
            return nil
        }
        
        dateFormatter.dateFormat = havingFormat
        
        if isUTC {
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
        }
        
        let returnDate = dateFormatter.date(from: dateString)
        dateFormatter.timeZone = TimeZone.current
        
        return returnDate
        
    }
}

// MARK: - All relating to timestamp
extension DateHelper {
    
    func getTimeInterval(for date: Date = Date(), since: Date = Date()) -> TimeInterval {
        return date.timeIntervalSince(since)
    }
    
    func getDate(adding time: TimeInterval = 0, to date: Date = Date()) -> Date {
        return date.addingTimeInterval(time)
    }
    
    func getDateString(adding time: TimeInterval = 0, to date: Date = Date(),
                       having format: String = "yyyy-MM-dd") -> String? {
        
        return DateHelper.shared.getStringDate(date.addingTimeInterval(time), havingFormat: format)
        
    }
    
}

// MARK: - Date object to String Date formatters
extension DateHelper {
    
    func getStringDate(_ fromDate: Date?, havingFormat: String) -> String {
        
        guard let date = fromDate else { return "" }
        dateFormatter.dateFormat = havingFormat
        return dateFormatter.string(from: date)
        
    }
    
}

// MARK: - String Date to String Date formatters
extension DateHelper {
    
    func getDateString(fromDateString: String?,
                       havingFormat: String = "yyyy-MM-dd HH:mms:ss",
                       addingInterval: Double,
                       toFormat: String = "yyyy-MM-dd HH:mms:ss",
                       stripToDay:Bool = false) -> String? {
        
        
        guard let dateString = fromDateString,
            let date = DateHelper.shared.getDateFrom(dateString: dateString, havingFormat: havingFormat) else {
            return nil
        }
        let newDate = date.addingTimeInterval(addingInterval)
        
        if DateHelper.shared.getStringDate(newDate, havingFormat: "yyyy-MM-dd")
            == DateHelper.shared.getStringDate(Date(), havingFormat: "yyyy-MM-dd")
            && stripToDay {
            
            return DateHelper.shared.getStringDate(newDate, havingFormat: "HH:mm a")
            
        }
        
        return DateHelper.shared.getStringDate(newDate, havingFormat: toFormat)
        
    }
    
    func getDateTime(_ dateString: String, inputFormat: String, outputFormat: String) -> String? {
        
        dateFormatter.dateFormat = inputFormat
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        if let date = dateFormatter.date(from: dateString) {
            
            
            dateFormatter.dateFormat = outputFormat
            let returnString = dateFormatter.string(from: date)
            dateFormatter.amSymbol = "am"
            dateFormatter.pmSymbol = "pm"
            return returnString
        }
        
        return nil
    }
}

// MARK: - Date object to Date object formatters
extension DateHelper {
    
    func getStrippedTime(for date: Date, having format: String = "HH:mm:ss") -> Date? {
        
        let dateString = DateHelper.shared.getStringDate(date, havingFormat: format)
        guard let strippedDate = DateHelper.shared.getDateFrom(dateString: dateString,
                                                               havingFormat: format,
                                                               isUTC: true) else { return nil}
        return strippedDate
        
    }
    
    func getLocalDateFor(date: Date, format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        
        dateFormatter.dateFormat = format
        let currentLocalString = dateFormatter.string(from: date)
        return dateFormatter.date(from: currentLocalString )
        
    }
    
}


