//
//  Misc.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 20/10/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Misc {
    class func getDoubleToCurrency(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(Double(number)))!
    }
    class func getNSDateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM"
        return formatter.string(from: date)
    }
    
    class func getStringToNSDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: string)!
    }
}
