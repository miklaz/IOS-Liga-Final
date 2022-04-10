//
//  FlashVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 09.04.2022.
//

import UIKit
import AVFoundation

final class FlashVC: UIViewController  {
    
    private var flashView = FlashView()
    
    init(_ touchCardView: FlashView) {
        self.flashView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = flashView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flashView.torchButton.addTarget(self, action: #selector(activeFlash), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
    
    deinit {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else{
            return
        }
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == .on) {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            }
            catch {
                print(error)
            }
        }
    }
    
    private func flashlight() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == .on) {
                    device.torchMode = .off
                    self.flashView.statusLabel.text = "Light OFF"
                    self.flashView.torchButton.setTitle("☼", for: .normal)
                }
                else {
                    device.torchMode = .on
                    self.flashView.statusLabel.text = "Light ON"
                    self.flashView.torchButton.setTitle("☀︎", for: .normal)
                }
                device.unlockForConfiguration()
            }
            catch {
                self.flashView.statusLabel.text = "Torch could not be used!"
                self.flashView.torchButton.alpha = 0
                print(error)
            }
        }
        else {
            self.flashView.statusLabel.text = "Torch is not available!"
            self.flashView.torchButton.alpha = 0
            print("Torch is not available")
        }
    }
    
    @objc private func activeFlash() {
        flashlight()
    }
}
