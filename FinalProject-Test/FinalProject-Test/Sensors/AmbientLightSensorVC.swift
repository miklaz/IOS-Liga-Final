//
//  AmbientLightSensorVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 08.04.2022.
//

import UIKit

final class AmbientLightSensorVC: UIViewController {
    
// MARK: - Const, Var & Outlets
    private var ambientLightSensorView = StandartSensorsTestView()
    private let lightStartStatus = UIScreen.main.brightness
    
    init(_ touchCardView: StandartSensorsTestView) {
        self.ambientLightSensorView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = ambientLightSensorView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ambientLightSensorView.statusLabel.text = "Hold there until the test is comlite."
        ambientLightSensorView.dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        addObservers()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    deinit {
        removeObservers()
        _ = UIDevice.current.isProximityMonitoringEnabled = false
    }
    
    
    // MARK: - Methods
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onScreenBrightnessChanged(_:)), name: UIScreen.brightnessDidChangeNotification, object:nil)
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func onScreenBrightnessChanged(_ sender: Notification) {
        if (UIScreen.main.brightness < lightStartStatus) == true || (UIScreen.main.brightness > lightStartStatus) == true //0...1
        {
            ambientLightSensorView.statusLabel.text = "Good, ambient light sensor works!"
        }
        else {
            ambientLightSensorView.statusLabel.text = "Hold there until the test is comlite."
        }
        
    }
    
    
    
    @objc private func dismissAction() {
        print("dismis")
        dismiss(animated: true, completion: nil)
    }

    
}
