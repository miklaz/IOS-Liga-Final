//
//  PhotoView.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 09.04.2022.
//

import UIKit

class PhotoView: UIView {
    
    lazy var photoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.layer.cornerRadius = 15
        image.layer.borderWidth = 4
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.systemBlue.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var view = BaseUIView(backgroundColor: .systemBackground)
    
    lazy var takePhotoButton = BaseUIButton(normalTitle: "Take photo",
                                            highlightedTitle: nil,
                                            setNormalTitleColor: .systemBlue,
                                            setHighlightedTitleColor: nil,
                                            fontSize: 15,
                                            fontWeight: .medium,
                                            cornerRadius: 0)
    
    lazy var savePhotoButton = BaseUIButton(normalTitle: "Save photo",
                                            highlightedTitle: nil,
                                            setNormalTitleColor: .systemBlue,
                                            setHighlightedTitleColor: nil,
                                            fontSize: 15,
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

extension PhotoView {
    func configuration(){
        addSubview(view)
        view.addSubview(dismissButton)
        view.addSubview(takePhotoButton)
        view.addSubview(savePhotoButton)
        view.addSubview(photoImage)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            photoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 74),
            photoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            photoImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            photoImage.bottomAnchor.constraint(equalTo: takePhotoButton.topAnchor, constant: -16),

            takePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            takePhotoButton.heightAnchor.constraint(equalToConstant: 30),
            takePhotoButton.widthAnchor.constraint(equalToConstant: 90),
            takePhotoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            
            savePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            savePhotoButton.heightAnchor.constraint(equalToConstant: 30),
            savePhotoButton.widthAnchor.constraint(equalToConstant: 90),
            savePhotoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dismissButton.heightAnchor.constraint(equalToConstant: 45),
            dismissButton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
}
