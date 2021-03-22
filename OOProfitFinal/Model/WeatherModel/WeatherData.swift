//
//  WeatherData.swift
//  OOProfitFinal
//
//  Created by Anan Yousef on 21/03/2021.
//

import Foundation

struct WeatherData: Codable {
    let name : String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    
}
