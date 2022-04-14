//
//  MainMenuCollectionViewCell.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 06.04.2022.
//

import UIKit

final class MainMenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private let imageTest: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let titleTest: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let statusView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed.withAlphaComponent(0.75)
        view.layer.cornerRadius = 7.5
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageTest)
        contentView.addSubview(titleTest)
        contentView.addSubview(statusView)
        contentView.clipsToBounds = true
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configCell (label: String, image: UIImage) {
        let borderColor = UIColor.systemBlue.withAlphaComponent(0.4)
        titleTest.text = label
        imageTest.image = image
        contentView.layer.borderColor = borderColor.cgColor //.systemBlue.cgColor
        contentView.layer.borderWidth = 3
        contentView.layer.cornerRadius = 20
    }

    func configuration(){
        NSLayoutConstraint.activate([
            imageTest.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageTest.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            imageTest.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            titleTest.topAnchor.constraint(equalTo: imageTest.bottomAnchor),
            titleTest.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleTest.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleTest.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            statusView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            statusView.leadingAnchor.constraint(equalTo: imageTest.trailingAnchor, constant: 2),
            //statusView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            statusView.widthAnchor.constraint(equalToConstant: 15),
            statusView.heightAnchor.constraint(equalToConstant: 15)

        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleTest.text = nil
    }
    
}
