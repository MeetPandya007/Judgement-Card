//
//  UserDefaultHelper.swift
//  Judgement Card
//
//  Created by Meetkumar Pandya on 2024-12-20.
//

import Foundation

class UserDefaultHelper {
    
    static let shared = UserDefaultHelper()
    let userDefaults = UserDefaults.standard
    
    func setPlayerDetails(data: [String:Int]){
        userDefaults.set(data, forKey: "PlayerScore")
    }
    
    func getPlayerDetails() -> [String:Int]{
        return userDefaults.value(forKey: "PlayerScore") as? [String:Int] ?? [:]
    }
}

