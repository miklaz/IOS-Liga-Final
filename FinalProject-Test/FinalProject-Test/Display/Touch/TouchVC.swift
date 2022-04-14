//
//  TouchVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 07.04.2022.
//

import UIKit

final class TouchVC: UIViewController  {
    
    private var touchView = CanvasTouch()
    
    init(_ touchCardView: CanvasTouch) {
        self.touchView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = touchView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        touchView.dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        touchView.backgroundColor = .orange
        touchView.frame = view.frame

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
}

extension TouchVC {
    @objc private func dismissAction() {
        print("dismis")
        dismiss(animated: true, completion: nil)
    }
}
