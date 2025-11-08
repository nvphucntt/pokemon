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
            
            var components = DateComponents()
            components.year = 2025
            components.month = 11
            components.day = 9
            components.hour = 21
            components.minute = 0
            components.second = 0
            components.timeZone = japanTimeZone
            
            guard let targetDate = calendar.date(from: components) else {
                return false
            }
            
            return now > targetDate
    }
    
    func isAfter19hInVN() -> Bool {
        let calendar = Calendar.current
            let now = Date()
            
            guard let vnTimeZone = TimeZone(identifier: "Asia/Ho_Chi_Minh") else {
                return false
            }
            
            var components = DateComponents()
            components.year = 2025
            components.month = 11
            components.day = 9
            components.hour = 19
            components.minute = 0
            components.second = 0
            components.timeZone = vnTimeZone
            
            guard let targetDate = calendar.date(from: components) else {
                return false
            }
            
            return now > targetDate
    }
}
