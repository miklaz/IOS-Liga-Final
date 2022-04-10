//
//  ContrastAndGammaView.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 07.04.2022.
//

import UIKit

final class ContrastAndGammaView: UIView {
// MARK: - Const & Var
    //var goToNavigationVC: (() -> Void)?
    //var goToModallyVC: (() -> Void)?
    
    private let items = ["Contrast", "Gradient", "Gamma"]
    private let colorOpt = ["Contrast_iphone11", "Gradient_iphone11", "Gamma_iphone11"]
    private var isBleach = false
    
//    private lazy var dismissButton = BaseUIButton(normalTitle: "✕",
//                                                  highlightedTitle: nil,
//                                                  setNormalTitleColor: .white,
//                                                  setHighlightedTitleColor: nil,
//                                                  fontSize: 30,
//                                                  fontWeight: .medium,
//                                                  cornerRadius: 0)
        
    private lazy var colorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Contrast_iphone11")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(ContrastAndGammaView.segmentAction(_:)), for: .valueChanged)
        segmentedControl.backgroundColor = .init(white: 1, alpha: 0.6)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    init(){
        super.init(frame: .zero)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Metods
extension ContrastAndGammaView{
    func configuration(){
        //dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)

        addSubview(colorImage)
        //addSubview(dismissButton)
        addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            colorImage.topAnchor.constraint(equalTo: self.topAnchor),
            colorImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            segmentedControl.bottomAnchor.constraint(equalTo: colorImage.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 31),
            segmentedControl.centerXAnchor.constraint(equalTo: colorImage.centerXAnchor),
            
//            dismissButton.topAnchor.constraint(equalTo: colorImage.safeAreaLayoutGuide.topAnchor, constant: 10),
//            dismissButton.leadingAnchor.constraint(equalTo: colorImage.leadingAnchor, constant: 20),
//            dismissButton.heightAnchor.constraint(equalToConstant: 45),
//            dismissButton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
}
    
// MARK: - @objc Metods
extension ContrastAndGammaView {
    @objc func segmentAction(_ sender: UISegmentedControl) {
        colorImage.image = UIImage(named: colorOpt[self.segmentedControl.selectedSegmentIndex])
    }
    
//    @objc func dismissAction() {
//        //self.dismiss(animated: true, completion: nil)
//        print("dismis")
//    }
    
//    @objc
//    private func toNavigationVC(){
//        goToNavigationVC!()
//    }
//
//    @objc
//    private func toModallyVC(){
//        goToModallyVC!()
//    }
    
}

