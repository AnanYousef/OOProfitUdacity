//
//  WeatherManeger.swift
//  OOProfitFinal
//
//  Created by Anan Yousef on 21/03/2021.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManeger,weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManeger {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=e9683b692fd6b744cdd07765b8a6c010&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchweather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchweather(latitude: CLLocationDegrees, longitute: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitute)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
               
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name =  decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    

    }

