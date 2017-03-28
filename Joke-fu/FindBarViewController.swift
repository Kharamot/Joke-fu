//
//  FindBarViewController.swift
//  Joke-fu
//
//  Created by Kameron Haramoto on 3/26/17.
//  Copyright © 2017 Kameron Haramoto. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FindBarViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var MKMapView: MKMapView!
    var geoCoder = CLGeocoder()
    let request = MKLocalSearchRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeLocation()
        MKMapView.userTrackingMode = .follow
    }

    override func viewWillAppear(_ animated: Bool) {
        let status = CLLocationManager.authorizationStatus()
        if((status == .authorizedAlways) || (status == .authorizedWhenInUse))
        {
            self.startLocation()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ShowBarsButtonPressed(_ sender: UIButton) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "bar"
        request.region = self.MKMapView.region
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("\(response!.mapItems.count) matches found")
                self.MKMapView.removeAnnotations(self.MKMapView.annotations)
                for item in response!.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.MKMapView.addAnnotation(annotation)
                } }
        })
    }
    
    //LOCATION
    
    var locationManager: CLLocationManager!
    func initializeLocation() { // called from start up method
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.startLocation()
        case .denied, .restricted:
            print("location not authorized")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        } }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if ((status == .authorizedAlways) || (status == .authorizedWhenInUse)) {
            self.startLocation()
        } else {
            self.stopLocation()
        }
    }
    func startLocation () {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    func stopLocation () {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        //var globalLocation: CLLocation!
        //self.geoCoder.reverseGeocodeLocation(globalLocation, completionHandler: geoCodeHandler)
    }
    
    func geoCodeHandler (placemarks: [CLPlacemark]?, error: Error?) {
        if let placemark = placemarks?.first {
            if let name = placemark.name {
                print("place name = \(name)")
            }
        }
    }
    
    

    
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
