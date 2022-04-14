//
//  ContrastAndGammaVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 14.04.2022.
//

import UIKit

class ContrastAndGammaVC: UIViewController {
    
    private lazy var colorImage1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Contrast_iphone11")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var colorImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Gradient_iphone11")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var colorImage3: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Gamma_iphone11")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .gray
        return scrollView
    }()
    
    lazy var dismissButton = BaseUIButton(normalTitle: "✕",
                                                  highlightedTitle: nil,
                                                  setNormalTitleColor: .white,
                                                  setHighlightedTitleColor: nil,
                                                  fontSize: 30,
                                                  fontWeight: .medium,
                                                  cornerRadius: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
}

extension ContrastAndGammaVC {
    func configuration(){
        view.backgroundColor = .systemBackground
        
        scrollView.addSubview(dismissButton)
        view.addSubview(scrollView)
        scrollView.addSubview(colorImage1)
        scrollView.addSubview(colorImage2)
        scrollView.addSubview(colorImage3)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dismissButton.topAnchor.constraint(equalTo: scrollView.topAnchor),
            dismissButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            dismissButton.heightAnchor.constraint(equalToConstant: 45),
            dismissButton.widthAnchor.constraint(equalToConstant: 45),
            
            colorImage1.topAnchor.constraint(equalTo: dismissButton.bottomAnchor),
            colorImage1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            colorImage1.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            colorImage1.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            colorImage1.heightAnchor.constraint(equalToConstant: view.frame.size.height),
            
            colorImage2.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            colorImage2.topAnchor.constraint(equalTo: colorImage1.bottomAnchor, constant: 16.0),
            colorImage2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            colorImage2.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            colorImage2.heightAnchor.constraint(equalToConstant: view.frame.size.height),
            
            colorImage3.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            colorImage3.topAnchor.constraint(equalTo: colorImage2.bottomAnchor, constant: 16.0),
            colorImage3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            colorImage3.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            colorImage3.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            colorImage3.heightAnchor.constraint(equalToConstant: view.frame.size.height),
            
        ])
    }
    
    @objc private func dismissAction() {
        self.dismiss(animated: true, completion: nil)
        print("dismis")
    }
}

