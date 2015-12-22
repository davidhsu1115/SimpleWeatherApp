//
//  WeatherService.swift
//  SimpleWeather
//
//  Created by fangwiehsu on 2015/12/8.
//  Copyright © 2015年 Evan Dekhayser. All rights reserved.
//

import Foundation

protocol WeatherServiceByTypeCityDelegate{
    
    func setWeatherByTypeCity(weather:Weather)
    
}

class WeatherServiceByTypeCity{
    
    var delegate:WeatherServiceByTypeCityDelegate?
    
    // TODO 寫一個方法傳入的引數是cityName, 另一個方法傳入引數是latitude, longitude
    
    func getWeather(city:String){
        
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=8a49046459d314dde6f920c401203b9c"
        let url = NSURL(string: path)
        
        //session connect to the internet and exchange data from the server
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            //Using SwiftyJSON to use the JSON object from internet
            let json = JSON(data:data!)
            let lon = json["coord"]["lon"].double
            let lat = json["coord"]["lat"].double
            let temp = json["main"]["temp"].double
            let maxTemperature = json["main"]["temp_max"].double
            let mintemperature = json["main"]["temp_min"].double
            let name = json["name"].string
            let humidity = json["main"]["humidity"].double
            let icon = json["weather"][0]["icon"].string
            let desc = json["weather"][0]["description"].string
            let windSpeed = json["wind"]["speed"].double

            //passing the weather data
            let weather = Weather(cityName: name!, temp: temp!, description: desc!, icon: icon!, maxTemp: maxTemperature!, minTemp: mintemperature!, humidity: humidity!, windSpeed: windSpeed!)
            
            
            if self.delegate != nil{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.delegate?.setWeatherByTypeCity(weather)
                })
                
            }
            
        }
        
        task.resume()
        
        
        
    }
    
    
    
}
