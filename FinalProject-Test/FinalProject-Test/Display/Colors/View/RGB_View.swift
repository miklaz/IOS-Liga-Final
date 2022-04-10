//
//  RGB_View.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 06.04.2022.
//

import UIKit

final class RGB_View: UIView {
// MARK: - Const & Var
    // to do
    //var goToNavigationVC: (() -> Void)?
    //var goToModallyVC: (() -> Void)?
    
    private let items = ["Red", "Green", "Blue"]
    private let colorOpt = [UIColor.red, UIColor.green, UIColor.blue]
    private let colorOptItem = [UIColor.white, UIColor.black, UIColor.white]
    private var isBleach = false
    
    lazy var infoHideItems = BaseUILabel(text: "Tap to hide items",
                                                 fontSize: 20,
                                                 fontWeight: .medium,
                                                 textColor: .white,
                                                 cornerRadius: 13)
    
//    lazy var dismissButton = BaseUIButton(normalTitle: "✕",
//                                                  highlightedTitle: nil,
//                                                  setNormalTitleColor: .white,
//                                                  setHighlightedTitleColor: nil,
//                                                  fontSize: 30,
//                                                  fontWeight: .medium,
//                                                  cornerRadius: 0)
    
    lazy var colorView = BaseUIView(backgroundColor: .red)
            
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(RGB_View.segmentAction(_:)), for: .valueChanged)
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
extension RGB_View {
    func configuration(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        colorView.addGestureRecognizer(tapGestureRecognizer)
        
        addSubview(colorView)
        colorView.addSubview(infoHideItems)
//        colorView.addSubview(dismissButton)
        colorView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: self.topAnchor),
            colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            infoHideItems.topAnchor.constraint(equalTo: colorView.safeAreaLayoutGuide.topAnchor, constant: 150),
            infoHideItems.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 20),
            infoHideItems.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -20),
                        
            segmentedControl.bottomAnchor.constraint(equalTo: colorView.safeAreaLayoutGuide.bottomAnchor, constant: -190),
            segmentedControl.heightAnchor.constraint(equalToConstant: 31),
            segmentedControl.centerXAnchor.constraint(equalTo: colorView.centerXAnchor),

//            dismissButton.topAnchor.constraint(equalTo: colorView.safeAreaLayoutGuide.topAnchor, constant: 10),
//            dismissButton.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 20),
//            dismissButton.heightAnchor.constraint(equalToConstant: 45),
//            dismissButton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
}
    
// MARK: - @objc Metods
extension RGB_View {
    @objc func handleTap() {
        UIView.animate(withDuration: 0.3) {
            self.isBleach = !self.isBleach
            self.segmentedControl.alpha = self.isBleach ? 0 : 1.0
//            self.dismissButton.alpha = self.isBleach ? 0 : 1.0
            self.infoHideItems.alpha = self.isBleach ? 0 : 1.0
        }
    }
    
    @objc func segmentAction(_ sender: UISegmentedControl) {
        colorView.backgroundColor = colorOpt[segmentedControl.selectedSegmentIndex]
        infoHideItems.textColor = colorOptItem[segmentedControl.selectedSegmentIndex]
//        dismissButton.tintColor = colorOptItem[segmentedControl.selectedSegmentIndex]
//        dismissButton.setTitleColor(colorOptItem[segmentedControl.selectedSegmentIndex], for: .normal)
        
    }
    
// to do
    
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

