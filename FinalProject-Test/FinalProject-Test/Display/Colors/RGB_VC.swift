//
//  RGB_VC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 06.04.2022.
//

import UIKit

final class RGB_VC: UIViewController  {
    
    private var rgbView = RGB_View()
    
    init(_ touchCardView: RGB_View) {
        self.rgbView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = rgbView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbView.dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
    
}

extension RGB_VC {
    @objc private func dismissAction() {
        self.dismiss(animated: true, completion: nil)
        print("dismis")
    }
}
