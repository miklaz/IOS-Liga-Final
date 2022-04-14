//
//  BluetoothVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 09.04.2022.
//

import UIKit
import CoreBluetooth

final class BluetoothVC: UIViewController  {
    
    private var bluetoothView = StandartConnectionTestView()
    private var centralManager: CBCentralManager!
    
    init(_ touchCardView: StandartConnectionTestView) {
        self.bluetoothView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = bluetoothView
        view.isOpaque = true
    }   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        bluetoothView.settingsButton.alpha = 0
        bluetoothView.settingsButton.addTarget(self, action: #selector(openBluetoothSettingsAction), for: .touchUpInside)
        bluetoothView.settingsButton.setTitle("Open Bluetooth Settings", for: .normal)
        bluetoothView.dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
    
    private func showAlert(_ title: String) {   //  Выводит сообщения в виде alert
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    private func showAlertBluetoothSettings (title: String, message:String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Open", style: .default) { (alert) in
            UIApplication.shared.open(URL(string: "App-prefs:Bluetooth")!)
        }
        
        let cancelAction = UIAlertAction (title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func openBluetoothSettingsAction() {
        showAlertBluetoothSettings (title: "Open Wi-Fi Settings?", message: "")
    }
    
    @objc private func dismissAction() {
        self.dismiss(animated: true, completion: nil)
        print("dismis")
    }
}

extension BluetoothVC: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .poweredOff:
                print("Is Powered Off.")
            bluetoothView.statusLabel.text = "Bluetooth is turned off.\nPlease turn on Bluetooth!"
            bluetoothView.statusLabel.textColor = .systemRed
            bluetoothView.settingsButton.alpha = 1
            case .poweredOn:
                print("Is Powered On.")
            bluetoothView.statusLabel.text = "Bluetooth is working!"
            bluetoothView.statusLabel.textColor = .systemGreen
            bluetoothView.settingsButton.alpha = 0
            case .unsupported:
                print("Is Unsupported.")
            bluetoothView.statusLabel.text = "Bluetooth is not supported on your device.\n(or Bluetooth is not working)"
            bluetoothView.statusLabel.textColor = .systemRed
            bluetoothView.settingsButton.alpha = 1
            case .unauthorized:
                    print("Is Unauthorized.")
            case .unknown:
                print("Unknown")
                showAlert("Unknown error :(")
            case .resetting:
                print("Resetting")
            @unknown default:
                print("Error")
        }
    }
}
