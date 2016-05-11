//
//  WeatherUndergoundServiceByGeographical.swift
//  SimpleWeatherApp
//
//  Created by fangwiehsu on 2016/1/15.
//  Copyright © 2016年 fangwiehsu. All rights reserved.
//

import Foundation

protocol WeatherUndergroundServiceByGeographicalDelegate{
    
    func setWeatherByGeographical(weather:WeatherUnderground)
}

class WeatherUndergoundServiceByGeographical{
    
    var delegate:WeatherUndergroundServiceByGeographicalDelegate?
    
    func getWeatherFromWeatherUnderground(latitude:Double, longitude:Double){
        
        let path = "http://api.wunderground.com/api/48675fd2f5485cff/conditions/geolookup/lang:TW/q/\(latitude),\(longitude).json"
        let url = NSURL(string: path)
        
        
        //session
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            let json = JSON(data: data!)
            //parsing json weather condition from weather api. using swiftyJson
            let name = json["current_observation"]["display_location"]["city"].string
            let temp = json["current_observation"]["temp_c"].double
            let windsp = json["current_observation"]["wind_mph"].double
            
            //prasing the weather data
            let weather = WeatherUnderground(cityName: name!, temperature: temp!, windSpeed: windsp!)
            
            if self.delegate != nil{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.delegate?.setWeatherByGeographical(weather)
                    
                })
            }
        }
        task.resume()
    }
    
    
}