//
//  SaleCell.swift
//  TestApp
//
//  Created by ARMBP on 4/4/23.
//

import UIKit


class SaleCell: UICollectionViewCell {
    
    public static let reuseID          = "saleCell"
    private let foodImageView          = CustomImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodImageView.setDefaultImage()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func set(foodItem: Food){
        foodImageView.downloadImage(fromURL: foodItem.image)
    }
    
    
    private func configure(){
        addSubview(foodImageView)
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        foodImageView.contentMode = .scaleToFill

        NSLayoutConstraint.activate([
            foodImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            foodImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            foodImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            foodImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
     }
}

