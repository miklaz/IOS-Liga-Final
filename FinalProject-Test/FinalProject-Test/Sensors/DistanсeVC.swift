//
//  DistanсeVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 08.04.2022.
//

import UIKit

final class DistanсeVC: UIViewController {
    
    // MARK: - Const, Var & Outlets
    //@IBOutlet weak var statusLabel: UILabel!
    private var distanсeView = StandartSensorsTestView()
    
    init(_ touchCardView: StandartSensorsTestView) {
        self.distanсeView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = distanсeView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distanсeView.statusLabel.text = "Hold there until the test is comlite."
        activateProximitySensor()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
    
    deinit {
        _ = UIDevice.current.isProximityMonitoringEnabled = false
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @objc func proximityChangedd(notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            print("\(device.name) detected!")
                distanсeView.statusLabel.text = "Good, Proximity sensor works!"
        }
    }
    
    // MARK: - Methods
    private func activateProximitySensor() {
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        if device.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(self, selector: #selector(proximityChangedd(notification:)), name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: device)
        }
    }
    
    
// MARK: - To do
//    @IBAction func dismissAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
}

