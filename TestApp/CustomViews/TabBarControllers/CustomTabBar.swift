//
//  CustomTabBar.swift
//  TestApp
//
//  Created by ARMBP on 4/4/23.
//

import UIKit

class CustomTabBar: UIViewController {
    
    private lazy var tabBar              = UIStackView()
    public  lazy var menuVC              = MenuVC()
    private lazy var contactsVC          = ContactsVC()
    private lazy var profileVC           = ProfileVC()
    private lazy var cartVC              = CartVC()
    private lazy var menuVCButton       = UIButton()
    private lazy var contactsVCButton   = UIButton()
    private lazy var profileVCButton        = UIButton()
    private lazy var cartVCButton      = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setVC(vc: menuVC)
        configureButtons()
    }
    
    override func viewDidLayoutSubviews() {
        makeButtonCircle(buttons: [menuVCButton, contactsVCButton, profileVCButton, cartVCButton])
    }
    
    
    private func configure(){
        view.addSubview(tabBar)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.backgroundColor = .systemGray5
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 20
        tabBar.addArrangedSubview(menuVCButton)
        tabBar.addArrangedSubview(contactsVCButton)
        tabBar.addArrangedSubview(profileVCButton)
        tabBar.addArrangedSubview(cartVCButton)
        tabBar.axis = .horizontal
        tabBar.alignment = .center
        tabBar.distribution = .equalCentering
        tabBar.spacing = 5
        tabBar.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tabBar.isLayoutMarginsRelativeArrangement = true
        
        NSLayoutConstraint.activate([
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            tabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 80),
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    
    
    private func configureButtons(){
        var storeButtonConfiguration = UIButton.Configuration.filled()
        storeButtonConfiguration.image = UIImage(systemName: "takeoutbag.and.cup.and.straw.fill")
        menuVCButton.configuration = storeButtonConfiguration
        menuVCButton.addAction(UIAction{_ in
            self.setVC(vc: self.menuVC)
        }, for: .touchUpInside)
        
        var cartButtonConfiguration = UIButton.Configuration.filled()
        cartButtonConfiguration.image = UIImage(systemName: "mappin.circle.fill")?.withTintColor(.systemRed)
        contactsVCButton.configuration = cartButtonConfiguration
        contactsVCButton.addAction(UIAction{_ in
            self.setVC(vc: self.contactsVC)
        }, for: .touchUpInside)
        
        var favoriteButtonConfiguration = UIButton.Configuration.filled()
        favoriteButtonConfiguration.image = UIImage(systemName: "person.fill")
        profileVCButton.configuration = favoriteButtonConfiguration
        profileVCButton.addAction(UIAction{ _ in
            self.setVC(vc: self.profileVC)
        }, for: .touchUpInside)
        
        var personButtonConfiguration = UIButton.Configuration.filled()
        personButtonConfiguration.image = UIImage(systemName: "cart.fill")
        cartVCButton.configuration = personButtonConfiguration
        cartVCButton.addAction(UIAction{_ in
            self.setVC(vc: self.cartVC)
        }, for: .touchUpInside)
    }
    
    
    
    private func setVC(vc: UIViewController){
        DispatchQueue.main.async { [self] in
            let arrayVC      = [menuVC, contactsVC, profileVC, cartVC]
            let buttonsArray = [menuVCButton, contactsVCButton, profileVCButton, cartVCButton]
            
            for view in arrayVC {
                view.view.removeFromSuperview()
                willMove(toParent: nil)
                view.removeFromParent()
            }
            
            addChild(vc)
            vc.view.frame = view.bounds
            view.addSubview(vc.view)
            vc.didMove(toParent: self)
            
            for button in buttonsArray {
                button.configuration?.baseForegroundColor = .systemGray
                button.configuration?.baseBackgroundColor = .white
            }
            
            switch vc {
            case self.menuVC:
                menuVCButton.configuration?.baseForegroundColor = Colors.selectedColor
                menuVCButton.configuration?.baseBackgroundColor = .systemGray6
                view.bringSubviewToFront(tabBar)
            case self.contactsVC:
                contactsVCButton.configuration?.baseForegroundColor = Colors.selectedColor
                contactsVCButton.configuration?.baseBackgroundColor = .systemGray6
                view.bringSubviewToFront(tabBar)
            case self.profileVC:
                profileVCButton.configuration?.baseForegroundColor = Colors.selectedColor
                profileVCButton.configuration?.baseBackgroundColor = .systemGray6
                view.bringSubviewToFront(tabBar)
            case self.cartVC:
                cartVCButton.configuration?.baseForegroundColor = Colors.selectedColor
                cartVCButton.configuration?.baseBackgroundColor = .systemGray6
                view.bringSubviewToFront(tabBar)
            default:
                break
            }
        }
    }
    
    
    private func makeButtonCircle(buttons: [UIButton]){
        for i  in buttons{
            i.widthAnchor.constraint(equalToConstant: 50).isActive = true
            i.heightAnchor.constraint(equalToConstant: 50).isActive = true
            i.clipsToBounds = true
            i.layer.cornerRadius = 0.5 * i.bounds.size.width
        }
    }
}
