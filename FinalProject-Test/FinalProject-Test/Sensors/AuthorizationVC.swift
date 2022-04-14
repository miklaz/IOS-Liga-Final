//
//  AuthorizationVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 08.04.2022.
//

import UIKit
import LocalAuthentication

final class AuthorizationVC: UIViewController {

// MARK: - Const, Var & Outlets
    private var authorizationView = AuthorizationView()
    
    init(_ touchCardView: AuthorizationView) {
        self.authorizationView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = authorizationView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizationView.statusLabel.text = ""
        authorizationView.authorizationButton.addTarget(self, action: #selector(scanID), for: .touchUpInside)
        authorizationView.dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc
    private func scanID() {
        let context:LAContext = LAContext ()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We want to login with your finger print or face", reply: { (wasCorrrct, error) in
                if wasCorrrct {
                    print("Correct")
                    DispatchQueue.main.async {
                        self.authorizationView.statusLabel.text = "Good, TouchID/FaceID works!"
                        self.authorizationView.authorizationButton.alpha = 0
                    }
                }
                else {
                    print("Incorrect")
                    DispatchQueue.main.async {
                        self.authorizationView.statusLabel.text = "Oops... it looks like TouchID/FaceID doesn't work :(  Maybe again?"
                    }
                }
            })
        }
        else {
            print ("Doesn't work")
            authorizationView.statusLabel.text = "Oops... it looks like TouchID/FaceID doesn't work :("
        }
    }
    
    //to do dismiss
    @objc private func dismissAction() {
        print("dismis")
        dismiss(animated: true, completion: nil)
    }
}
