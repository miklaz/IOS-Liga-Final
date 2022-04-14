//
//  HeadphonesSpeakView.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 08.04.2022.
//

import UIKit

class HeadphonesSpeakView: UIView {
    private lazy var view = BaseUIView(backgroundColor: .systemBackground)
    
    lazy var statusLabel = BaseUILabel(text: "Please connect your headphones!",
                                       fontSize: 20,
                                       fontWeight: .medium,
                                       textColor: .label,
                                       cornerRadius: 13)
    
    lazy var playButton = BaseUIButton(normalTitle: "▶︎",
                                                highlightedTitle: nil,
                                                setNormalTitleColor: .systemBlue,
                                                setHighlightedTitleColor: nil,
                                                fontSize: 64,
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

extension HeadphonesSpeakView {
    func configuration(){
        
        addSubview(view)
        view.addSubview(statusLabel)
        view.addSubview(dismissButton)
        view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 90),
            playButton.widthAnchor.constraint(equalToConstant: 90),
            
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dismissButton.heightAnchor.constraint(equalToConstant: 45),
            dismissButton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
}
