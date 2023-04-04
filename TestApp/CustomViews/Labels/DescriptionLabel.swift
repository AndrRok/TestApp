//
//  DescriptionLabel.swift
//  TestApp
//
//  Created by ARMBP on 4/4/23.
//

import UIKit

class MessageLabel: UILabel {
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
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure(){
        textColor                                   = UIColor.systemGray
        adjustsFontSizeToFitWidth                   = true
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
        numberOfLines                               = 0
        adjustsFontSizeToFitWidth                   = false
        
    }
}
