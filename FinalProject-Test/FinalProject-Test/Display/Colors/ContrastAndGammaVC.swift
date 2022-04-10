//
//  ContrastAndGammaVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 07.04.2022.
//

import UIKit

final class ContrastAndGammaVC: UIViewController  {
    
    private var contrastView = ContrastAndGammaView()
    
    init(_ touchCardView: ContrastAndGammaView) {
        self.contrastView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = contrastView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
}
