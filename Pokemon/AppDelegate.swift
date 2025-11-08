//
//  AppDelegate.swift
//  Pokemon
//
//  Created by Van Phu on 27/9/25.
//

import UIKit

enum IPhoneScreenType {
    case small_se          // 1136 - iPhone SE 1st gen, 5, 5s
    case small_6_7_8       // 1334 - iPhone 6, 6s, 7, 8
    case medium_x_xs_11Pro // 2436 - iPhone X, XS, 11 Pro, 12/13 mini
    case large_xr_11       // 1792 - iPhone XR, 11
    case large_12normal    // 2340 - iPhone 12, 12 Pro, 13, 13 Pro, 14
    case large_12Pro       // 2532 - iPhone 12 Pro, 13 Pro, 14 Pro (6.1 inch)
    case pro_14Pro_15Pro   // 2556 - iPhone 14 Pro, 15 Pro
    case proMax_14ProMax   // 2778 - iPhone 14 Pro Max
    case proMax_15ProMax   // 2796 - iPhone 15 Pro Max
    case other
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let screenType = getIPhoneScreenType()
            DataStore.shared.currentDevice = screenType
        switch screenType {
            case .small_se:
                print("👉 Màn hình nhỏ (iPhone SE 1st gen, 5, 5s)")
                
            case .small_6_7_8:
                print("👉 Màn hình nhỏ (iPhone 6, 6s, 7, 8)")
                
            case .medium_x_xs_11Pro:
                print("👉 Màn hình trung bình (iPhone X, XS, 11 Pro, 12/13 mini)")
                
            case .large_xr_11:
                print("👉 Màn hình lớn (iPhone XR, 11)")
                
            case .large_12normal:
                print("👉 Màn hình lớn (iPhone 12, 13, 14 thường)")
                
            case .large_12Pro:
                print("👉 Màn hình lớn (iPhone 12 Pro, 13 Pro, 14 Pro)")
                
            case .pro_14Pro_15Pro:
                print("👉 Màn hình Pro (iPhone 14 Pro, 15 Pro)")
                
            case .proMax_14ProMax:
                print("👉 Màn hình Pro Max (iPhone 14 Pro Max)")
                
            case .proMax_15ProMax:
                print("👉 Màn hình Pro Max (iPhone 15 Pro Max)")
                
            case .other:
                print("👉 Loại khác hoặc simulator")
            }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    
    func getIPhoneScreenType() -> IPhoneScreenType {
        let height = max(UIScreen.main.nativeBounds.height,
                         UIScreen.main.nativeBounds.width)
        
        switch height {
        case 1136:
            return .small_se
            
        case 1334:
            return .small_6_7_8
            
        case 1792:
            return .large_xr_11
            
        case 2340:
            return .large_12normal
            
        case 2436:
            return .medium_x_xs_11Pro
            
        case 2532:
            return .large_12Pro
            
        case 2556:
            return .pro_14Pro_15Pro
            
        case 2778:
            return .proMax_14ProMax
            
        case 2796:
            return .proMax_15ProMax
            
        default:
            return .other
        }
    }
}

