//
//  CanvasTouch.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 07.04.2022.
//

import UIKit

final class CanvasTouch: UIView {
// MARK: - Const & Var
    // to do
    //var goToNavigationVC: (() -> Void)?
    //var goToModallyVC: (() -> Void)?
    
    private var lines = [[CGPoint]]()

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

// MARK: - Private Metods
extension CanvasTouch {
    private func configuration(){
        addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            dismissButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dismissButton.heightAnchor.constraint(equalToConstant: 45),
            dismissButton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(60)
        context.setLineCap(.round)
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        context.strokePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}

