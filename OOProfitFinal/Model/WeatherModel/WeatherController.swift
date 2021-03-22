//
//  WeatherController.swift
//  OOProfitFinal
//
//  Created by Anan Yousef on 21/03/2021.
//

import Foundation
import UIKit
import CoreLocation

class WeatherController: UIViewController{
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var weatherManager = WeatherManeger()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        activityIndicator.hidesWhenStopped = true
        
        
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
        activityIndicator.startAnimating()
        
        
        
        
    }
    
    
    
}
// MARK: - UItextFieldDelegate

extension WeatherController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        activityIndicator.startAnimating()
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        activityIndicator.startAnimating()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = " Type something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchweather(cityName: city)
        }
        searchTextField.text = ""
        
        
    }
    
}

// MARK: - WeatherManagerDelegate

extension WeatherController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManeger, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionNmae)
            self.cityLabel.text = weather.cityName
            self.activityIndicator.stopAnimating()
        }
    }
        func didFailWithError(error: Error) {
            print(error)
        }
}

extension WeatherController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchweather(latitude: lat, longitute: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}

    


