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
}
