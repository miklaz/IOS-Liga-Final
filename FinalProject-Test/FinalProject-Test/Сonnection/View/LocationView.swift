//
//  LocationView.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 09.04.2022.
//

import UIKit
import MapKit

final class LocationView: UIView {
// MARK: - Const & Var
    //var goToNavigationVC: (() -> Void)?
    //var goToModallyVC: (() -> Void)?
    private lazy var view = BaseUIView(backgroundColor: .systemBackground)
    
    lazy var statusLabel = BaseUILabel(text: "You are here?",
                                               fontSize: 20,
                                               fontWeight: .medium,
                                               textColor: .label,
                                               cornerRadius: 0)
    
    lazy var yesButton = BaseUIButton(normalTitle: "Yes",
                                                  highlightedTitle: nil,
                                                  setNormalTitleColor: .systemBlue,
                                                  setHighlightedTitleColor: nil,
                                                  fontSize: 20,
                                                  fontWeight: .medium,
                                                  cornerRadius: 10)
    
    lazy var noButton = BaseUIButton(normalTitle: "No",
                                                  highlightedTitle: nil,
                                                  setNormalTitleColor: .systemBlue,
                                                  setHighlightedTitleColor: nil,
                                                  fontSize: 20,
                                                  fontWeight: .medium,
                                                  cornerRadius: 10)
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    init(){
        super.init(frame: .zero)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Metods
extension LocationView {
    func configuration() {
        yesButton.backgroundColor = .init(white: 1, alpha: 0.4)
        noButton.backgroundColor = .init(white: 1, alpha: 0.4)
        statusLabel.backgroundColor = .init(white: 1, alpha: 0.4)
 
        addSubview(view)
        mapView.addSubview(statusLabel)
        view.addSubview(mapView)
        view.addSubview(yesButton)
        view.addSubview(noButton)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            statusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 36),
            
            yesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yesButton.trailingAnchor.constraint(equalTo: noButton.leadingAnchor, constant: -20),
            yesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            yesButton.widthAnchor.constraint(equalTo: noButton.widthAnchor),
            
            noButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            noButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}
    
// MARK: - @objc Metods
extension LocationView {
    
//    @objc
//    private func toNavigationVC(){
//        goToNavigationVC!()
//    }
//
//    @objc
//    private func toModallyVC(){
//        goToModallyVC!()
//    }
    
}

