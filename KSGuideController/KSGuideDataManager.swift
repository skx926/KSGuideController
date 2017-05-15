//
//  KSGuideDataManager.swift
//  KSGuideController
//
//  Created by Kyle Sun on 2017/5/15.
//  Copyright © 2017年 Kyle Sun. All rights reserved.
//

import Foundation

public class KSGuideDataManager: NSObject {
    
    static let userDefaults = UserDefaults.standard
    static let dataKey = "KSGuideDataKey"
    
    public static func reset(for key: String) {
        if var data = userDefaults.object(forKey: dataKey) as? [String: Bool] {
            data.removeValue(forKey: key)
            userDefaults.set(data, forKey: dataKey)
        }
    }
    
    public static func resetAll() {
        userDefaults.set(nil, forKey: dataKey)
    }
    
    static func shouldShowGuide(with key: String) -> Bool {
        if var data = userDefaults.object(forKey: dataKey) as? [String: Bool] {
            if let _ = data[key] {
                return false
            }
            data[key] = true
            userDefaults.set(data, forKey: dataKey)
            return true
        }
        let data = [key: true]
        userDefaults.set(data, forKey: dataKey)
        return true
    }
}
