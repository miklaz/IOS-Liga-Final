//
//  CellularVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 09.04.2022.
//

import UIKit

final class CellularVC: UIViewController  {
    
    private var cellularView = StandartConnectionTestView()
    private var prefsURl: String = ""
    
    init(_ touchCardView: StandartConnectionTestView) {
        self.cellularView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = cellularView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellularView.settingsButton.alpha = 0
        cellularView.settingsButton.addTarget(self, action: #selector(openSettingsAction), for: .touchUpInside)
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
            self.cellularView.statusLabel.text = "Cellular is turned off.\nPlease turn on cellular!"
            self.cellularView.statusLabel.textColor = .systemRed
            prefsURl = "App-prefs:"
            self.cellularView.settingsButton.setTitle("Open settings", for: .normal)
            self.cellularView.settingsButton.alpha = 1
        case .wwan:
            self.cellularView.statusLabel.text = "Cellular is working!"
            self.cellularView.statusLabel.textColor = .systemGreen
            self.cellularView.settingsButton.alpha = 0
        case .wifi:
            self.cellularView.statusLabel.text = "Please turn off Wi-Fi!"
            self.cellularView.statusLabel.textColor = .systemYellow
            prefsURl = "App-prefs:WIFI"
            self.cellularView.settingsButton.setTitle("Open Wi-fi settings", for: .normal)
            self.cellularView.settingsButton.alpha = 1
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    private func showAlertSettings (title: String, message:String?,url:URL?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Open", style: .default) { (alert) in
            if let url = url{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
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
        showAlertSettings(title: "Open Settings?", message: "", url: URL(string: prefsURl))
    }
}

