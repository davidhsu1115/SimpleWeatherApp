//
//  Weather.swift
//  SimpleWeather
//
//  Created by fangwiehsu on 2015/12/8.
//  Copyright © 2015年 Evan Dekhayser. All rights reserved.
//

import Foundation

struct Weather{
    
    
    let cityName:String
    let temp:Double
    let description:String
    let icon:String
    let maxTemp:Double
    let minTemp:Double
    let humidity:Double
    let windSpeed:Double
    
    init(cityName:String, temp:Double, description:String, icon:String, maxTemp:Double, minTemp:Double, humidity:Double, windSpeed:Double){
        self.cityName = cityName
        self.temp = temp
        self.icon = icon
        self.description = description
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.humidity = humidity
        self.windSpeed = windSpeed
        }
}