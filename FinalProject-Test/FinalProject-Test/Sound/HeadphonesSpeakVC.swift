//
//  HeadphonesSpeakVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 08.04.2022.
//

import UIKit
import AVFoundation

final class HeadphonesSpeakVC: UIViewController {
    
    // MARK: - Const, Var & Outlets
    private var headphonesSpeakView = HeadphonesSpeakView()
    private let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "testSound", ofType: "mp3")!)
    private let fakeSound = URL(fileURLWithPath: Bundle.main.path(forResource: "fakeSound2", ofType: "mp3")!)
    private var audioPlayer = AVAudioPlayer()
    private var headphonesConnected: Bool = false
    
    init(_ touchCardView: HeadphonesSpeakView) {
        self.headphonesSpeakView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = headphonesSpeakView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headphonesSpeakView.playButton.alpha = 0
        headphonesSpeakView.playButton.addTarget(self, action: #selector(playSound), for: .touchUpInside)
        setupNotifications()
        playFakeSound()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func showAlert(_ title: String) {   //  Выводит сообщения в виде alert
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func playFakeSound() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fakeSound)
            audioPlayer.play()
        } catch {
            print("Couldn't load file :(")
        }
    }
    
    private func setupNotifications() {
        // Get the default notification center instance.
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(handleRouteChange),
                       name: AVAudioSession.routeChangeNotification,
                       object: nil)
    }
    
    @objc func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
                return
        }
        
        // Switch over the route change reason.
        switch reason {
        case .newDeviceAvailable: // New device found.
            let session = AVAudioSession.sharedInstance()
            headphonesConnected = hasHeadphones(in: session.currentRoute)
            headphonesSpeakView.statusLabel.text = "Headphone plugged in!"
            headphonesSpeakView.playButton.alpha = 1
        
        case .oldDeviceUnavailable: // Old device removed.
            if let previousRoute =
                userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
                headphonesConnected = hasHeadphones(in: previousRoute)
                headphonesSpeakView.statusLabel.text = "Headphone pulled out!"
                headphonesSpeakView.playButton.alpha = 0
            }
        
        default: ()
        }
    }

    func hasHeadphones(in routeDescription: AVAudioSessionRouteDescription) -> Bool {
        // Filter the outputs to only those with a port type of headphones.
        return !routeDescription.outputs.filter({$0.portType == .headphones}).isEmpty
    }
    
    
    @objc private func playSound() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
            audioPlayer.play()
        } catch {
            showAlert("Couldn't load file :(")
        }
        
        self.headphonesSpeakView.statusLabel.text = "Okay, if you heard the sound, then the main speaker works!"
    }
    
    
// MARK: - To do
//    @IBAction func dismissAction(_ sender: Any) {
//    self.dismiss(animated: true, completion: nil)
//}
    
}

