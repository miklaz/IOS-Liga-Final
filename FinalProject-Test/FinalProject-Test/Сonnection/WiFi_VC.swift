//
//  WiFi_VC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 09.04.2022.
//

import UIKit

final class WiFi_VC: UIViewController  {
    
    private var wifiView = StandartConnectionTestView()
    
    init(_ touchCardView: StandartConnectionTestView) {
        self.wifiView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = wifiView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wifiView.settingsButton.alpha = 0
        wifiView.settingsButton.addTarget(self, action: #selector(openSettingsAction), for: .touchUpInside)
        wifiView.settingsButton.setTitle("Open Wi-Fi Settings", for: .normal)
        wifiView.dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLayoutSubviews()
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
        updateUserInterface()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func updateUserInterface() {
        switch Network.reachability.status {
        case .unreachable:
            wifiView.statusLabel.text = "Wi-Fi is turned off.\nPlease turn on Wi-Fi and select network!"
            wifiView.statusLabel.textColor = .systemRed
            wifiView.settingsButton.alpha = 1
        case .wwan:
            wifiView.statusLabel.text = "Please select a Wi-Fi network!"
            wifiView.statusLabel.textColor = .systemYellow
            wifiView.settingsButton.alpha = 1
        case .wifi:
            wifiView.statusLabel.text = "Wi-Fi is working and connected!"
            wifiView.statusLabel.textColor = .systemGreen
            wifiView.settingsButton.alpha = 0
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    private func showAlertWiFiSettings (title: String, message:String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Open", style: .default) { (alert) in
            UIApplication.shared.open(URL(string: "App-prefs:WIFI")!)
        }
        
        let cancelAction = UIAlertAction (title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    @objc private func openSettingsAction() {
        showAlertWiFiSettings (title: "Open Wi-Fi Settings?", message: "")
    }
    
    @objc private func dismissAction() {
        self.dismiss(animated: true, completion: nil)
        print("dismis")
    }
}
