//
//  BWG_VC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 07.04.2022.
//

import UIKit

final class BWG_VC: UIViewController  {
    
    private var bwgView = BWG_View()
    
    init(_ touchCardView: BWG_View) {
        self.bwgView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = bwgView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bwgView.dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
}

extension BWG_VC {
    @objc private func dismissAction() {
        self.dismiss(animated: true, completion: nil)
        print("dismis")
    }
}
