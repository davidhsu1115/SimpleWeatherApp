//
//  ViewController.swift
//  SimpleWeatherApp
//
//  Created by fangwiehsu on 2015/12/9.
//  Copyright © 2015年 fangwiehsu. All rights reserved.
//

import UIKit

import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, WeatherServiceByGeographicalDelegate, WeatherServiceByTypeCityDelegate, WeatherUndergroundServiceByTypeCityDelegate, WeatherUndergroundServiceByGeographicalDelegate{
    
    //ViewController 1
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var realTemperatureLabel: UILabel!
    @IBOutlet weak var bodyFeelLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var showRealTemperatureLabel: UILabel!
    @IBOutlet weak var showBodyTemperatureLabel: UILabel!
    
    //ViewController 2
    @IBOutlet weak var setCityTextField: UITextField!
    @IBOutlet weak var showTemperatureByTextCityLabel: UILabel!
    
    //----------------------------//
    
    
    let weatherServiceByGeographical = WeatherServiceByGeographical()
    let weatherServiceByTypeCity = WeatherServiceByTypeCity()
    let weatherUndergroundServiceByTypeCity = WeatherUndergroundServiceByTypeCity()
    let weatherUndergroundServiceByGeographical = WeatherUndergoundServiceByGeographical()
    
    let locationManager = CLLocationManager()
    
    var latitudeFromLocation:Double?
    var longitudeFromLocation:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherServiceByGeographical.delegate = self
        self.weatherServiceByTypeCity.delegate = self
        self.weatherUndergroundServiceByTypeCity.delegate = self
        self.weatherUndergroundServiceByGeographical.delegate = self
        
        
        //Core Location Manager ask for GPS location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
       
        
    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let myCurrentLocation = locations[locations.count - 1]
        
        latitudeFromLocation = myCurrentLocation.coordinate.latitude
        longitudeFromLocation = myCurrentLocation.coordinate.longitude
        
     
    }
    
    
    
    //button to open the side menu
    @IBAction func onBurger() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    //Button for set the weather information by Geographical coordinate
    @IBAction func setWeatherByGPSButton(sender: AnyObject) {
        
        if latitudeFromLocation != nil && longitudeFromLocation != nil{
        
            self.weatherUndergroundServiceByGeographical.getWeatherFromWeatherUnderground(latitudeFromLocation!, longitude: longitudeFromLocation!)
        
        }else{
                let alert = UIAlertController(title: "GPS Failed", message: "無法取得目前位置", preferredStyle: .Alert)
                let ok = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                })
                alert.addAction(ok)
        }
        
    }
    
    
    
    
    //Button for set the weather information by Set city
    @IBAction func setWeatherByTypeCityButton(sender: AnyObject) {
        
        if setCityTextField.text != nil{
            //self.weatherServiceByTypeCity.getWeather(setCityTextField.text!)
            self.weatherUndergroundServiceByTypeCity.getWeatherFromWeatherUnderground(setCityTextField.text!)
        }else{
            //add alert controller
            let textAlert = UIAlertController(title: "City Missing", message: "Please Enter The City", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                
            })
            textAlert.addAction(ok)
        }
    }
    
    
    
    func setWeatherByGeographical(weather: Weather) {
        let intTemp = Int(weather.temp - 273)
        let name = weather.cityName
        let icon = weather.icon
        let wind = (weather.windSpeed)
        let bodyTemperature = Int(weather.temp - 2*(sqrt(wind))) - 273
        
        showRealTemperatureLabel.text = "\(intTemp) °C"
        showBodyTemperatureLabel.text = "\(bodyTemperature) °C"
        cityNameLabel.text = name
        
    }
    
    //implement func from Weather Underground service by Geographical
    func setWeatherByGeographical(weather: WeatherUnderground) {
        let name = weather.cityName
        let windsp = (weather.windSpeed * 0.44704)  //convert mph to m/s
        let temp = Int(weather.temperature)
        let bodyTemp = Int(weather.temperature - 2*(sqrt(windsp)))
        
        showRealTemperatureLabel.text = "\(temp) °C"
        showBodyTemperatureLabel.text = "\(bodyTemp) °C"
        cityNameLabel.text = name
        
    }
    
    
        // --TODO code the weatherTypeByCity
    func setWeatherByTypeCity(weather: Weather) {
        let intTemp = Int(weather.temp - 273)
        let name = weather.cityName
        let icon = weather.icon
        let wind = (weather.windSpeed)
        let bodyTemperature = Int(weather.temp - 2*(sqrt(wind)))-273
        
        
        
// the weather information can't show in the same ViewController
        
        showTemperatureByTextCityLabel.text = "\(intTemp)"
        
//        showRealTemperatureLabel.text = "\(intTemp) °C"
//        showBodyTemperatureLabel.text = "\(bodyTemperature) °C"
//        cityNameLabel.text = name
        
    }
    
    func setWeatherByTypeCityInWeatherUnderground(weather: WeatherUnderground) {
        let intTemp = Int(weather.temperature)
        let name = weather.cityName
        
        showTemperatureByTextCityLabel.text = "\(intTemp)"
    }
    
    
    // --TODO change OpenWeatherMap Api into WeatherUnderground Api and add the precentage of rain.
    
    
}
