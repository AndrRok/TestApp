//
//  CustomImageView.swift
//  TestApp
//
//  Created by ARMBP on 4/4/23.
//

import UIKit

class CustomImageView: UIImageView {
    
    private let cache               = NetworkManager.shared.cache
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius                          = 10
        clipsToBounds                               = true
        image                                       = Images.placeholder
        translatesAutoresizingMaskIntoConstraints   = true
        contentMode                                 = .scaleAspectFill
    }
    
    
    public func downloadImage(fromURL url: String){
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {self.image = image ?? Images.placeholder}
        }
    }
    
    public func setDefaultImage(){
        DispatchQueue.main.async{
            self.image = Images.placeholder
        }
    }
}