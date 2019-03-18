//
//  WeatherLocation.swift
//  Weather Gift
//
//  Created by Anny Shan on 3/18/19.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var corrdinates = ""
    
    func getWeather() {
        let weatherURL = urlBase + urlAPIKey + corrdinates
        print(weatherURL)
        
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("*****json: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

