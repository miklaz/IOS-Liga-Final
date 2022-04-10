//
//  AccelerVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 08.04.2022.
//

import UIKit

final class AccelerVC: UIViewController {
    
    // MARK: - Const, Var & Outlets
    private var accelerView = StandartSensorsTestView()
    
    init(_ touchCardView: StandartSensorsTestView) {
        self.accelerView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = accelerView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accelerView.statusLabel.text = "Shake your device"
        self.becomeFirstResponder()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            accelerView.statusLabel.text = "Good, acceler works!"
            print("shake")
        }
    }
    
// MARK: - To do

    
}
