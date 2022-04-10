//
//  TouchVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 07.04.2022.
//

import UIKit

final class TouchVC: UIViewController {

    // MARK: - Const, Var & Outlets
    var canvas = CanvasTouch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvas)
        canvas.backgroundColor = .orange
        canvas.frame = view.frame
        //view.addSubview(dismissButton)
    }
    
    // MARK: - IBActions

    
//        override var prefersStatusBarHidden: Bool {
//             return true
//        }

}
