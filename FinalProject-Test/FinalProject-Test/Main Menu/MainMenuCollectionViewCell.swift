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
        image.image = UIImage(systemName: "house")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let titleTest: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageTest)
        contentView.addSubview(titleTest)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageTest.frame = CGRect(x: 6,
                             y: 6,
                             width: contentView.frame.size.width-10,
                             height: contentView.frame.size.height-50)
        
        titleTest.frame = CGRect(x: 6,
                             y: contentView.frame.size.height-50,
                             width: contentView.frame.size.width-10,
                             height: 50)
    }
    
    public func configCell (label: String, image: UIImage) {
        let borderColor = UIColor.systemBlue.withAlphaComponent(0.4)
        titleTest.text = label
        imageTest.image = image
        contentView.layer.borderColor = borderColor.cgColor //.systemBlue.cgColor
        contentView.layer.borderWidth = 3
        contentView.layer.cornerRadius = 20
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleTest.text = nil
    }
    
}
