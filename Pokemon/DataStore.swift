//
//  DataStore.swift
//  Pokemon
//
//  Created by Van Phu on 8/11/25.
//
import Foundation

class DataStore {
    static let shared = DataStore()
    
    enum BundleId {
        case Debug
    }
    
    static let USER_DEFAULT_DEBUG = (Bundle.main.bundleIdentifier ?? "com.au.app5g.work") + ".debug"
    
    
    private var userDefaults = UserDefaultsAccessor()
    var debugUserDefaults = UserDefaultsAccessor(userDefaults: UserDefaults.init(suiteName: USER_DEFAULT_DEBUG)!)
    
    var isComplete: Bool = false
    
    var isLogin: Bool
    {
        return userDefaults.get(key: .isLogin, type: Bool.self) ?? false
    }
    
    func update(isLogin: Bool) {
        userDefaults.set(key: .isLogin, value: isLogin)
    }
    
    var lastLoginDate: Date?
    {
        return userDefaults.get(key: .lastLoginDate, type: Date.self)
    }
    
    func update(lastLoginDate: Date) {
        userDefaults.set(key: .lastLoginDate, value: lastLoginDate)
    }
    
    func removeLoginDate() {
        userDefaults.remove(key: .lastLoginDate)
    }
    
    var currentDevice: IPhoneScreenType = .other
    
    func checkIfOver24hTokyo() -> Bool {
        guard let lastLogin = DataStore.shared.lastLoginDate else {
            return true
        }

        let tokyoTimeZone = TimeZone(identifier: "Asia/Tokyo")!
        var calendar = Calendar.current
        calendar.timeZone = tokyoTimeZone

        let now = Date()
        let interval = now.timeIntervalSince(lastLogin)

        if interval >= 24 * 60 * 60 {
            return true
        } else {
            return false
        }
    }
    
    func currentPass(for date: Date = Date()) -> String {
        let passes = ["0022", "2322", "8722", "4444000044440000"]
        
        // TimeZone Tokyo
        let tokyoTimeZone = TimeZone(identifier: "Asia/Tokyo")!
        var calendar = Calendar.current
        calendar.timeZone = tokyoTimeZone
        
        var startComponents = DateComponents()
        startComponents.year = 2025
        startComponents.month = 11
        startComponents.day = 14
        startComponents.hour = 0
        startComponents.minute = 0
        startComponents.second = 0
        startComponents.timeZone = tokyoTimeZone
        
        guard let startDate = calendar.date(from: startComponents) else {
            return passes.first ?? ""
        }
        
        if date < startDate {
            return passes.first ?? ""
        }
        
        let startOfDay = calendar.startOfDay(for: startDate)
        let currentDay = calendar.startOfDay(for: date)
        let daysPassed = calendar.dateComponents([.day], from: startOfDay, to: currentDay).day ?? 0
        
        let index = min(daysPassed, passes.count - 1)
        return passes[index]
    }
}

class UserDefaultsAccessor {

    enum UserDefaultKey: String {
        case isLogin
        case lastLoginDate
    }

    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func set<T>(key: UserDefaultKey, value: T) {
        userDefaults.set(value, forKey: key.rawValue)
    }

    func setData<T: Codable>(key: UserDefaultKey, data: T) {
        guard let value = try? JSONEncoder().encode(data) else {
            return
        }
        userDefaults.set(value, forKey: key.rawValue)
    }

    func get<T>(key: UserDefaultKey, type: T.Type) -> T? {
        return userDefaults.object(forKey: key.rawValue) as? T
    }

    func getData<T: Codable>(key: UserDefaultKey, type: T.Type) -> T? {
        guard
            let data = userDefaults.object(forKey: key.rawValue) as? Data,
            let value = try? JSONDecoder().decode(T.self, from: data)
        else {
            return nil
        }

        return value
    }

    func remove(key: UserDefaultKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
