//
//  ViewController.swift
//  Location Aware App Template
//
//  Created by Mohammad Kiani on 2021-01-17.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var latLbl: UILabel!
    @IBOutlet weak var lngLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var courseLbl: UILabel!
    @IBOutlet weak var altitudeLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        
        //ACCURACY
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // REQUEST THE USER FOR LOCATION ACCESS
        locationManager.requestWhenInUseAuthorization()
        
        // REQUEST UPDATES FOR LOCATION CHANGES
        locationManager.startUpdatingLocation()
    }


}

extension ViewController:
    CLLocationManagerDelegate{
    
    //listening the updates of the locations
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            latLbl.text = "\(location.coordinate.latitude)"
            lngLbl.text = "\(location.coordinate.longitude)"
            speedLbl.text = "\(location.speed)"
            courseLbl.text = "\(location.course)"
            altitudeLbl.text = "\(location.altitude)"

            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let placemark = placemarks?[0] {
                        
                        var address = ""
                        
                        if placemark.subThoroughfare != nil {
                            address += placemark.subThoroughfare! + " "
                        }
                        
                        if placemark.thoroughfare != nil {
                            address += placemark.thoroughfare! + "\n"
                        }
                        
                        if placemark.subLocality != nil {
                            address += placemark.subLocality! + "\n"
                        }
                        
                        if placemark.subAdministrativeArea != nil {
                            address += placemark.subAdministrativeArea! + "\n"
                        }
                        
                        if placemark.postalCode != nil {
                            address += placemark.postalCode! + "\n"
                        }
                        
                        if placemark.country != nil {
                            address += placemark.country! + "\n"
                        }
                        
                        self.addressLbl.text = address
                    }
                }
            }
            
        }
    }
}

