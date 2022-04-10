//
//  CompassVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 07.04.2022.
//

import UIKit
import CoreLocation

final class CompassVC: UIViewController {

    // MARK: - Const, Var & Outlets
    private let canvasView = CompassView()
    private let comppassLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    // MARK: - Methods
    private func config() {
        view.backgroundColor = .systemBackground
        canvasView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.width)
        canvasView.center = view.center
        canvasView.backgroundColor = .clear
        view.addSubview(canvasView)
        comppassLocationManager.delegate = self
        comppassLocationManager.startUpdatingHeading()
    }
}

extension CompassVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let angle = newHeading.trueHeading * .pi / 180
        UIView.animate(withDuration: 0.5) {
            self.canvasView.transform = CGAffineTransform(rotationAngle: -CGFloat(angle))
        }
    }
}
