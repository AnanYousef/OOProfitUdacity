//
//  UserDefaulsManager.swift
//  OOProfitFinal
//
//  Created by Anan Yousef on 21/03/2021.
//

import Foundation




class UserDefaulsManager {
    
    static let shared: UserDefaulsManager = UserDefaulsManager()
    
    static private let key: String = "Profits-Key"
    
    private var profits: [Profit]
    
    private let userDefaults = UserDefaults.standard
    
    private init() {
        
        self.profits = []
        
        
        if let encodedData = self.userDefaults.data(forKey: UserDefaulsManager.key), let decodedData = try? JSONDecoder().decode([Profit].self, from: encodedData) {
            
            
            self.profits = decodedData
        }
    }
    
    
    func addProfit(_ profit: Profit) {
        
        self.profits.append(profit)
        
        if let encodedData = try? JSONEncoder().encode(profits) {
            
            self.userDefaults.set(encodedData, forKey: Self.key)
        }
    }
    
    func getProfits() -> [Profit] {
        return self.profits
    }
}

