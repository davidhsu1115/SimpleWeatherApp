//
//  WeatherUndergroundService.swift
//  SimpleWeatherApp
//
//  Created by fangwiehsu on 2015/12/31.
//  Copyright © 2015年 fangwiehsu. All rights reserved.
//

import Foundation

protocol WeatherUndergroundServiceByTypeCityDelegate{
    
    func setWeatherByTypeCityInWeatherUnderground(weather:WeatherUnderground)
}


class WeatherUndergroundServiceByTypeCity{
    
    var delegate:WeatherUndergroundServiceByTypeCityDelegate?
    
    func getWeatherFromWeatherUnderground(city:String){
        
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        let path = "http://api.wunderground.com/api/48675fd2f5485cff/conditions/q/\(cityEscaped!).json"
        let url = NSURL(string:path)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            
            let json = JSON(data:data!)
            let name = json["current_observation"]["display_location"]["city"].string
            let temp = json["current_observation"]["temp_c"].double
            let windsp = json["current_observation"]["wind_mph"].double
            
            
            let weather = WeatherUnderground(cityName: name!, temperature: temp!, windSpeed: windsp!)
            
            if self.delegate != nil{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.delegate?.setWeatherByTypeCityInWeatherUnderground(weather)
                })
            }
            
        }
        
        task.resume()
        
    }
    
}