//
//  DataStore.swift
//  Pokemon
//
//  Created by Van Phu on 8/11/25.
//
import Foundation

class DataStore {
    static let shared = DataStore()
    var isComplete: Bool = false
    
    var currentDevice: IPhoneScreenType = .other
    
    func isAfter9PMTomorrowInJapan() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        
        guard let japanTimeZone = TimeZone(identifier: "Asia/Tokyo") else {
            return false
        }
        
        var tomorrowComponents = calendar.dateComponents(in: japanTimeZone, from: now)
        tomorrowComponents.day! += 1
        tomorrowComponents.hour = 21
        tomorrowComponents.minute = 0
        tomorrowComponents.second = 0
        
        guard let ninePMTomorrow = calendar.date(from: tomorrowComponents) else {
            return false
        }
        
        return now > ninePMTomorrow
    }
    
    func isAfter19hInVN() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        
        guard let japanTimeZone = TimeZone(identifier: "Asia/Tokyo") else {
            return false
        }
        
        var tomorrowComponents = calendar.dateComponents(in: japanTimeZone, from: now)
        tomorrowComponents.day! += 1
        tomorrowComponents.hour = 19
        tomorrowComponents.minute = 0
        tomorrowComponents.second = 0
        
        guard let ninePMTomorrow = calendar.date(from: tomorrowComponents) else {
            return false
        }
        
        return now > ninePMTomorrow
    }
}
