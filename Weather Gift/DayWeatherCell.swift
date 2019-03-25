//
//  DayWeatherCell.swift
//  Weather Gift
//
//  Created by Anny Shan on 3/25/19.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter
} ()

class DayWeatherCell: UITableViewCell {
    @IBOutlet weak var dayCellIcon: UIImageView!
    @IBOutlet weak var dayCellWeekday: UILabel!
    @IBOutlet weak var dayCellMaxTemp: UILabel!
    @IBOutlet weak var dayCellMinTemp: UILabel!
    @IBOutlet weak var dayCellSummary: UITextView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

    func update(with dailyForecast: WeatherDetail.DailyForecase, timeZone: String) {
        dayCellIcon.image = UIImage(named: dailyForecast.dailyIcon)
        dayCellSummary.text = dailyForecast.dailYSummary
        dayCellMaxTemp.text = String(format: "%2.f", dailyForecast.dailyMaxTemp) + "°"
        dayCellMinTemp.text = String(format: "%2.f", dailyForecast.dailyMinTemp) + "°"
        let dateString = dailyForecast.dailyDate.format(timeZone: timeZone, dateFormatter: dateFormatter)
        dayCellWeekday.text = dateString
    }
    
}
