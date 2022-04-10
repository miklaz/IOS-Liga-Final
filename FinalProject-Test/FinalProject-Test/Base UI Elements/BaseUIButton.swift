//
//  BaseUIButton.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 06.04.2022.
//

import UIKit

final class BaseUIButton: UIButton {
    
    init(normalTitle: String,
         highlightedTitle: String?,
         setNormalTitleColor: UIColor,
         setHighlightedTitleColor: UIColor?,
         fontSize: CGFloat,
         fontWeight: UIFont.Weight,
         cornerRadius: CGFloat?) {
        super.init(frame: .zero)
        
        setTitle(normalTitle, for: .normal)
        setTitle(highlightedTitle ?? normalTitle, for: .highlighted)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        backgroundColor = .clear
        setTitleColor(setNormalTitleColor, for: .normal)
        setTitleColor(setHighlightedTitleColor ?? setNormalTitleColor, for: .highlighted)
        layer.cornerRadius = cornerRadius ?? 0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
