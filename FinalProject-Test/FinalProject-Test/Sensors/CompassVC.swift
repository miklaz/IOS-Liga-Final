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
    
    private lazy var dismissButton = BaseUIButton(normalTitle: "✕",
                                                  highlightedTitle: nil,
                                                  setNormalTitleColor: .systemBlue,
                                                  setHighlightedTitleColor: nil,
                                                  fontSize: 30,
                                                  fontWeight: .medium,
                                                  cornerRadius: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
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
        
        view.addSubview(dismissButton)
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dismissButton.heightAnchor.constraint(equalToConstant: 45),
            dismissButton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    
    @objc private func dismissAction() {
        print("dismis")
        dismiss(animated: true, completion: nil)
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
