//
//  WeatherLocation.swift
//  Weather Gift
//
//  Created by Anny Shan on 3/18/19.
//

import Foundation
import Alamofire

class WeatherLocation {
    var name = ""
    var corrdinates = ""
    
    func getWeather() {
        let weatherURL = urlBase + urlAPIKey + corrdinates
        print(weatherURL)
        
        Alamofire.request(weatherURL).responseJSON { response in
            print(response)
        }
    }
}

