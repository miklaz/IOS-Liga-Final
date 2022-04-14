//
//  FlashView.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 09.04.2022.
//

import UIKit

class FlashView: UIView {
    private lazy var view = BaseUIView(backgroundColor: .systemBackground)
    
    lazy var statusLabel = BaseUILabel(text: "Light OFF",
                                       fontSize: 20,
                                       fontWeight: .medium,
                                       textColor: .label,
                                       cornerRadius: 13)
    
    lazy var torchButton = BaseUIButton(normalTitle: "☼",
                                                highlightedTitle: nil,
                                                setNormalTitleColor: .systemBlue,
                                                setHighlightedTitleColor: nil,
                                                fontSize: 130,
                                                fontWeight: .medium,
                                                cornerRadius: 0)
    
    lazy var dismissButton = BaseUIButton(normalTitle: "✕",
                                                  highlightedTitle: nil,
                                                  setNormalTitleColor: .systemBlue,
                                                  setHighlightedTitleColor: nil,
                                                  fontSize: 30,
                                                  fontWeight: .medium,
                                                  cornerRadius: 0)
    
    init(){
        super.init(frame: .zero)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlashView {
    func configuration(){
        
        addSubview(view)
        view.addSubview(statusLabel)
        view.addSubview(dismissButton)
        view.addSubview(torchButton)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            torchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            torchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            torchButton.heightAnchor.constraint(equalToConstant: 90),
            torchButton.widthAnchor.constraint(equalToConstant: 90),
            
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dismissButton.heightAnchor.constraint(equalToConstant: 45),
            dismissButton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
}

