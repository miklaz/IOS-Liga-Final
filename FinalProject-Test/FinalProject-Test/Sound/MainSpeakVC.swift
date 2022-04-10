//
//  MainSpeakVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 08.04.2022.
//

import UIKit
import AVFoundation

final class MainSpeakVC: UIViewController {
    
    // MARK: - Const, Var & Outlets
    private var mainSpeakView = MainSpeakView()
    private let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "testSound", ofType: "mp3")!)
    private var audioPlayer = AVAudioPlayer()
    
    init(_ touchCardView: MainSpeakView) {
        self.mainSpeakView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = mainSpeakView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainSpeakView.playButton.addTarget(self, action: #selector(playSound), for: .touchUpInside)
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
    
    @objc private func playSound() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
            audioPlayer.play()
        } catch {
            showAlert("Couldn't load file :(")
        }
        
        self.mainSpeakView.statusLabel.text = "Okay, if you heard the sound, then the main speaker works!"
        self.mainSpeakView.infoLabel.alpha = 0
    }
    
    
// MARK: - To do
//    @IBAction func dismissAction(_ sender: Any) {
//    self.dismiss(animated: true, completion: nil)
//}
    
}
