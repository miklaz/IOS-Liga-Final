//
//  LocationVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 09.04.2022.
//

import UIKit
import MapKit

final class LocationVC: UIViewController {

    // MARK: - Const & Var
    private var locationView = LocationView()
    private let locationManager = CLLocationManager()
    
    init(_ touchCardView: LocationView) {
        self.locationView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = locationView
        view.isOpaque = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationView.noButton.addTarget(self, action: #selector(noButtonAction), for: .touchUpInside)
        locationView.yesButton.addTarget(self, action: #selector(yesButtonAction), for: .touchUpInside)
        locationView.statusLabel.text = "You are here?"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        checkLocationEnabled()
    }
    // MARK: - Methods
    private func checkLocationEnabled () {
        if CLLocationManager.locationServicesEnabled() {
            setupManager ()
            checkAutorization()        }
        else {
            showAlertLocation (title: "You have geolocation turned off", message: "Want to turn on?", url: URL(string: "App-prefs:LOCATION_SERVICES"))
        }
    }
    
    private func setupManager () {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    private func checkAutorization () {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            locationView.mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            showAlertLocation(title: "You have banned the use of geolocation", message: "Want to change this?", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print ("Oops...")
        }
    }
    
    private func showAlertLocation (title: String, message:String?,url:URL?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alert) in
            if let url = url{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction (title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func noButtonAction() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func yesButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LocationVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 300, longitudinalMeters: 300)
            locationView.mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAutorization()
    }
}
