//
//  FrontSpeakVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 08.04.2022.
//

import UIKit
import AVFoundation

final class FrontSpeakVC: UIViewController {
    
    // MARK: - Const, Var & Outlets
    private var frontSpeakView = FrontSpeakView()
    private let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "testSound", ofType: "mp3")!)
    private var audioPlayer = AVAudioPlayer()
    
    init(_ touchCardView: FrontSpeakView) {
        self.frontSpeakView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = frontSpeakView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frontSpeakView.dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        activateProximitySensor(isOn: true)
        frontSpeakView.configuration()
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
    
    private func activateProximitySensor(isOn: Bool) {
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = isOn
        if isOn {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(proximityStateDidChange),
                                                   name: UIDevice.proximityStateDidChangeNotification,
                                                   object: device)
            
            let session = AVAudioSession.sharedInstance()
            do {
                try session.setCategory(.playAndRecord)
                try session.setActive(true)
                try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            } catch {
                print ("\(#file) - \(#function) error: \(error.localizedDescription)")
            }
        } else {
            NotificationCenter.default.removeObserver(self,
                                                      name: UIDevice.proximityStateDidChangeNotification,
                                                      object: device)
        }
    }
    
    private func showAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    @objc func proximityStateDidChange(notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            print("\(device.name) detected!")
            let session = AVAudioSession.sharedInstance()
            do{
                let routePort: AVAudioSessionPortDescription? = session.currentRoute.outputs.first
                let portType = routePort?.portType
                if let type = portType, type.rawValue == "Receiver" {
                    try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                } else {
                    try session.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
                        audioPlayer.play()
                        self.frontSpeakView.statusLabel.text = "Okay, if you heard the sound, then the main speaker works!"
                    } catch {
                        showAlert("Couldn't load file :(")
                    }
                    
                }
            } catch {
                print ("\(#file) - \(#function) error: \(error.localizedDescription)")
            }
            
        }
    }
    
    
    @objc private func dismissAction() {
        print("dismis")
        dismiss(animated: true, completion: nil)
    }
    
}

