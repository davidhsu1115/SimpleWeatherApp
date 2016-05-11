//
//  WeatherUnderground.swift
//  SimpleWeatherApp
//
//  Created by fangwiehsu on 2015/12/31.
//  Copyright © 2015年 fangwiehsu. All rights reserved.
//

import Foundation


struct WeatherUnderground {
    
    let cityName:String
    let temperature:Double
    let windSpeed:Double
    
    init(cityName:String, temperature:Double, windSpeed:Double){
        self.cityName = cityName
        self.temperature = temperature
        self.windSpeed = windSpeed
    }
}