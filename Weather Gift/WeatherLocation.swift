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
    var currentTemp = "--"
    var dailySumamry = ""
    
    func getWeather(completed: @escaping () -> ()) {
        let weatherURL = urlBase + urlAPIKey + corrdinates
        
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                } else {
                    print("Could not return a temperature.")
                }
                if let summary = json["daily"]["summary"].string {
                    self.dailySumamry = summary
                } else {
                    print("Cold not return a summary.")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}

