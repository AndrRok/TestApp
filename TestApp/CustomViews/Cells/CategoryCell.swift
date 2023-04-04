//
//  CategoryCell.swift
//  TestApp
//
//  Created by ARMBP on 4/4/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    private var cateogoryLabel           = NameLabel(textAlignment: .center, fontSize: 12)
    
    public static let reuseID = "categoryCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor =  Colors.mainBackGroundColor
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func set(text: String){
        cateogoryLabel.text = text
    }
    
    
    override var isSelected: Bool {
          didSet {
              DispatchQueue.main.async {
                  self.contentView.backgroundColor  = self.isSelected ? Colors.unselectedColor   : Colors.mainBackGroundColor
                  self.cateogoryLabel.textColor     = self.isSelected ? Colors.selectedColor     : Colors.selectedColor
                  self.contentView.layer.borderWidth  = self.isSelected ? 0  : 2
              }
          }
      }

    
//MARK: - Configure
    private func configure(){
        contentView.addSubview(cateogoryLabel)
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 2
        layer.cornerRadius = 20
        contentView.layer.borderColor = Colors.unselectedColor.cgColor
        backgroundColor = .white
        cateogoryLabel.textColor = Colors.selectedColor
        
        NSLayoutConstraint.activate([
            cateogoryLabel.topAnchor.constraint(equalTo: topAnchor),
            cateogoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cateogoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            cateogoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
