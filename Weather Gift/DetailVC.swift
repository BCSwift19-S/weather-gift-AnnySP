//
//  DetailVC.swift
//  Weather Gift
//
//  Created by Anny Shan on 3/11/19.
//

import UIKit
import CoreLocation

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM dd, y"
    return dateFormatter
} ()

class DetailVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var currentPage = 0
    var locationArray = [WeatherLocation]()
    var locationDetail: WeatherDetail!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        locationDetail = WeatherDetail(name: locationArray[currentPage].name, coordinates: locationArray[currentPage].coordinates)
        
        if currentPage != 0 {
            self.locationDetail.getWeather {
                self.updateUserInterface()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentPage == 0 {
            getLocation()
        }
    }
    
    func updateUserInterface() {
        locationLabel.text = locationDetail.name
//        let dateString = formatTimeForTimeZone(unixDate: location.currentTime, timeZone: location.timeZone)
        let dateString = locationDetail.currentTime.format(timeZone: locationDetail.timeZone, dateFormatter: dateFormatter)
        dateLabel.text = dateString
        temperatureLabel.text = locationDetail.currentTemp
        summaryLabel.text = locationDetail.currentSummart
        currentImage.image = UIImage(named: locationDetail.currentIcon)
        tableView.reloadData()
        collectionView.reloadData()
    }
   
}

extension DetailVC: CLLocationManagerDelegate {
    func getLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            print("I'm sorry - can't show location. User has not authorized it.")
        case .restricted:
            print("Access denied. Likely parental controls are restrict location services in this app.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geoCoder = CLGeocoder()
        var place = ""
        currentLocation = locations.last
        let currentLatitude = currentLocation.coordinate.latitude
        let currentLongitude = currentLocation.coordinate.longitude
        let currentCoordinates = "\(currentLatitude),\(currentLongitude)"
        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            placemarks, error in
            if placemarks != nil {
                let placemark = placemarks?.last
                place = (placemark?.name)!
            } else {
                print("Error retreiving place. Error code: \(error!)")
                place = "Unknown Weather Location"
            }
            self.locationArray[0].name = place
            self.locationArray[0].coordinates = currentCoordinates
            self.locationDetail = WeatherDetail(name: place, coordinates: currentCoordinates)
            self.locationDetail.getWeather {
                self.updateUserInterface()
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location.")
    }
}

extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationDetail.dailyForecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell", for: indexPath) as! DayWeatherCell
        let timeZone = locationDetail.timeZone
        cell.update(with: locationDetail.dailyForecastArray[indexPath.row], timeZone: timeZone)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension DetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationDetail.hourlyForecaseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourlyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCell", for: indexPath) as! HourlyWeatherCell
        let hourlyForecast = locationDetail.hourlyForecaseArray[indexPath.row]
        let timeZone = locationDetail.timeZone
        hourlyCell.update(with: hourlyForecast, timeZone: timeZone)
        return hourlyCell
    }
    
}

