//
//  PriceLabel.swift
//  TestApp
//
//  Created by ARMBP on 4/4/23.
//

import UIKit

class PriceLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat){
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    private func configure(){
        textColor                                   = Colors.selectedColor
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
        layer.cornerRadius                          = 10
        layer.masksToBounds                         = true
        numberOfLines                               = 1
        adjustsFontSizeToFitWidth                   = true
        layer.borderColor = Colors.selectedColor.cgColor
        layer.borderWidth = 2
        
    }
    
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
                super.drawText(in: rect.inset(by: insets))
    }
}

