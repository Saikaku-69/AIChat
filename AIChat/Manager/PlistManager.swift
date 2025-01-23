//
//  PlistManager.swift
//  AIChat
//
//  Created by cmStudent on 2025/01/22.
//

import Foundation

class PlistManager {
    static let shared = PlistManager()
    
    private init() {}
    
    func getValue(forKey key: String, fromPlist plistName: String) -> Any? {
        if let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String : Any] {
            return dict[key]
        }
        return nil
    }
}
