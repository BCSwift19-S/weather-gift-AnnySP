//
//  DetailVC.swift
//  Weather Gift
//
//  Created by Anny Shan on 3/11/19.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    var currentPage = 0
    var locationArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationLabel.text = locationArray[currentPage]
        
    }
    
}
