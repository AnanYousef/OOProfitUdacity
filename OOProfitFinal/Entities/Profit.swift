//
//  Profit.swift
//  OOProfitFinal
//
//  Created by Anan Yousef on 21/03/2021.
//

import Foundation


struct Profit: Codable {
    
    var loadPay: Int
    
    var profit: Int
    
    enum CodingKeys: CodingKey {
        case loadPay
        case profit
    }
}
