//
//  FoodItemCell.swift
//  TestApp
//
//  Created by ARMBP on 4/4/23.
//

import UIKit

class FoodItemCell: UICollectionViewCell {
    
    public static let reuseID = "foodItemCell"
    private lazy var foodNameLabel           = NameLabel(textAlignment: .left, fontSize: 18)
    private lazy var foodDescriptionLabel    = UITextView()
    private lazy var foodPriceLabel          = PriceLabel(textAlignment: .left, fontSize: 30)
    private let foodImageView                = CustomImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodImageView.setDefaultImage()
    }
    
    public func setFromAPI(foodItem: Food){
        foodNameLabel.text = foodItem.name
        foodDescriptionLabel.text = foodItem.description
        foodPriceLabel.text = "от \(String(foodItem.price)) руб"
        foodImageView.downloadImage(fromURL: foodItem.image)
    }
    
    private func configure(){
        addSubviews(foodImageView, foodNameLabel, foodDescriptionLabel, foodPriceLabel)
        foodNameLabel.translatesAutoresizingMaskIntoConstraints        = false
        foodDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        foodPriceLabel.translatesAutoresizingMaskIntoConstraints       = false
        foodImageView.translatesAutoresizingMaskIntoConstraints        = false
        
        foodDescriptionLabel.textColor = .systemGray
        foodDescriptionLabel.isUserInteractionEnabled = false
        foodDescriptionLabel.textContainer.maximumNumberOfLines = 0
        foodDescriptionLabel.isScrollEnabled = false
        foodDescriptionLabel.font = .systemFont(ofSize: 20)
        foodDescriptionLabel.textContainer.lineBreakMode = .byTruncatingTail
        
        NSLayoutConstraint.activate([
            foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.25*Values.padding),
            foodImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 150),
            foodImageView.widthAnchor.constraint(equalTo: foodImageView.heightAnchor),
            
            foodNameLabel.topAnchor.constraint(equalTo: foodImageView.topAnchor),
            foodNameLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 0.25*Values.padding),
            foodNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0.25*Values.padding),
            
            foodDescriptionLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 0.25*Values.padding),
            foodDescriptionLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 0.25*Values.padding),
            foodDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0.25*Values.padding),
            foodDescriptionLabel.bottomAnchor.constraint(equalTo: foodImageView.bottomAnchor),
            
            
            foodPriceLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 0.25*Values.padding),
            foodPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0.25*Values.padding),
            foodPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0.25*Values.padding),
        ])
    }
    
}
