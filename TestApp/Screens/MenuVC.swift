//
//  MenuVC.swift
//  TestApp
//
//  Created by ARMBP on 4/4/23.
//

import UIKit

protocol ScrollCategoriesMenuDelegate{
    func scrollCategoriesMenuTo(rowOfHeader: Int)
    
}

protocol SendSalesDataToHeaderProtocol{
    func sendDataToHeader(foodArray: [Food])
}


class MenuVC: DataLoadingVC {
    
    private var timer: Timer?
    
    private lazy var navBar = UINavigationBar(frame: .zero)
    private lazy var collectionView         = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createLayout(in: view))
    private lazy var headerViewCategories   = CategoriesHeaderView(frame: .zero)
    private lazy var chooseCityButton       = UIButton()
    private lazy var chevronDownImage       = UIImageView()
    
    
    private lazy var wholeFoodArray  : [Food] = []
    private lazy var pizzaArray      : [Food] = []
    private lazy var burgersArray    : [Food] = []
    private lazy var dessertArray    : [Food] = []
    private lazy var drinkArray      : [Food] = []
    private lazy var comboArray      : [Food] = []
    
    private var delegateThree: ScrollCategoriesMenuDelegate?
    private var sendDataDelegate: SendSalesDataToHeaderProtocol?
    
    private lazy var isSelectingCategory = Bool()
    private lazy var neededIndexPath = IndexPath(row: 0, section: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    private func configure(){
        configureLocationButton()
        configureNB()
        configureCollectionView()
        configureStickyHeader(space: Values.salesHeaderHeight + Values.padding)
        getFood()
        headerViewCategories.delegateTwo = self
        self.delegateThree = headerViewCategories
        isSelectingCategory = false
    }
    
    
    //MARK: - Get API Data
    private func getFood(){
        showLoadingView()
        NetworkManager.shared.getFoodList()  { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let resultsFood):
                self.wholeFoodArray = resultsFood
                self.sortArrayByCategory()
                self.reloadCollectionView()
                self.dismissLoadingView()
            case .failure(let error):
                self.presentCustomAllertOnMainThred(allertTitle: "Bad Stuff Happend", message: error.rawValue, butonTitle: "Ok")
            }
        }
    }
    
    
    //MARK: - Configure UI
    private func configureNB(){
        view.addSubview(navBar)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navBar.shadowImage = UIImage()
        navBar.backgroundColor = .systemBackground
        let navItem = UINavigationItem()
        let chooseCityButton          = UIBarButtonItem(customView: chooseCityButton)
        navItem.leftBarButtonItem = chooseCityButton
        navBar.setItems([navItem], animated: false)
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            navBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func configureLocationButton(){
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: "chevron.down", withConfiguration: configuration)
        chevronDownImage.image = image
        chevronDownImage.tintColor = .label
        chevronDownImage.translatesAutoresizingMaskIntoConstraints = false
        chooseCityButton.addSubview(chevronDownImage)
        chooseCityButton.setTitle("Moscow", for: .normal)
        chooseCityButton.titleLabel?.font = UIFont(name: "Montserrat", size: 14)
        chooseCityButton.setTitleColor(.label, for: .normal)
        
        NSLayoutConstraint.activate([
            chooseCityButton.widthAnchor.constraint(equalToConstant: 100),
            chooseCityButton.heightAnchor.constraint(equalToConstant: 35),
            
            chevronDownImage.leadingAnchor.constraint(equalTo: chooseCityButton.trailingAnchor, constant: -5),
            chevronDownImage.centerYAnchor.constraint(equalTo: chooseCityButton.centerYAnchor)
        ])
    }
    
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        collectionView.showsVerticalScrollIndicator               = false
        collectionView.register(FoodItemCell.self, forCellWithReuseIdentifier: FoodItemCell.reuseID)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID)
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)//adds space in the end of tableView
        collectionView.contentInset = insets
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    
    private func configureStickyHeader(space: CGFloat){
        headerViewCategories.removeFromSuperview()
        view.addSubview(headerViewCategories)
        headerViewCategories.translatesAutoresizingMaskIntoConstraints = false
        headerViewCategories.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            headerViewCategories.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: space),
            headerViewCategories.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerViewCategories.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerViewCategories.widthAnchor.constraint(equalToConstant: view.frame.width),
            headerViewCategories.heightAnchor.constraint(equalToConstant: Values.categoriesqHeaderHeight)
        ])
    }
    
    
    
    
    private func sortArrayByCategory(){
        pizzaArray      = wholeFoodArray.filter {$0.foodType.contains("pizza")   }
        burgersArray    = wholeFoodArray.filter {$0.foodType.contains("burger")  }
        dessertArray    = wholeFoodArray.filter {$0.foodType.contains("dessert") }
        drinkArray      = wholeFoodArray.filter {$0.foodType.contains("drink")   }
        comboArray      = wholeFoodArray.filter {$0.foodType.contains("combo")   }
    }
    
    
    private func reloadCollectionView(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension MenuVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (section) {
            
        case 0://Empty
            return 0
        case 1://Pizza
            return pizzaArray.count
            
        case 2://Burgers
            return burgersArray.count
            
        case 3://Dessert
            return dessertArray.count
            
        case 4://Drink
            return drinkArray.count
            
        case 5://Combo
            return comboArray.count
            
        default:
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodItemCell.reuseID, for: indexPath) as! FoodItemCell
        switch (indexPath.section) {
        case 1://Pizza
            let pizzaAPI = pizzaArray[indexPath.row]
            cell.setFromAPI(foodItem: pizzaAPI)
            
        case 2://Burgers
            let burgerAPI = burgersArray[indexPath.row]
            cell.setFromAPI(foodItem: burgerAPI)
            
        case 3://Dessert
            let dessertAPI = dessertArray[indexPath.row]
            cell.setFromAPI(foodItem: dessertAPI)
            
        case 4://Drink
            let drinkAPI = drinkArray[indexPath.row]
            cell.setFromAPI(foodItem: drinkAPI)
            
        case 5://Combo
            let comboAPI = comboArray[indexPath.row]
            cell.setFromAPI(foodItem: comboAPI)
            
        default:
            break
        }
        return cell
    }
}



extension MenuVC{
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as! SectionHeader
            sendDataDelegate = sectionHeader
            sendDataDelegate?.sendDataToHeader(foodArray: self.wholeFoodArray)
            sectionHeader.backgroundColor = .systemBackground
            collectionView.bringSubviewToFront(sectionHeader)
            
            switch (indexPath.section) {
            case 0://Empty
                
                sectionHeader.configureForZeroSection()
                
            case 1://Pizza
                sectionHeader.configureForOtherSecions()
                sectionHeader.label.text =  "Pizza"
                
            case 2://Burgers
                sectionHeader.configureForOtherSecions()
                sectionHeader.label.text =  "Burgers"
                
            case 3://Dessert
                sectionHeader.configureForOtherSecions()
                sectionHeader.label.text =  "Dessert"
                
            case 4://Drink
                sectionHeader.configureForOtherSecions()
                sectionHeader.label.text =  "Drink"
                
            case 5://Combo
                sectionHeader.configureForOtherSecions()
                sectionHeader.label.text =  "Combo"
                
            default:
                break
            }
            return sectionHeader
            
        } else {
            return UICollectionReusableView()
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let fullyVisibleIndexPaths = (collectionView.indexPathsForFullyVisibleItems().first?.section ?? 1) - 1
        let offSetY = scrollView.contentOffset.y//already scrolled data
        
        switch offSetY {
        case 0:
            configureStickyHeader(space: Values.salesHeaderHeight + Values.padding)
        case 1...Values.salesHeaderHeight:
            configureStickyHeader(space: (Values.salesHeaderHeight + Values.padding - offSetY))
        case Values.salesHeaderHeight...:
            configureStickyHeader(space: 0)
        default:
            configureStickyHeader(space: (-offSetY + Values.salesHeaderHeight + Values.padding))
        }
        
        //Stop sync scrolling
        guard isSelectingCategory else {
            self.delegateThree?.scrollCategoriesMenuTo(rowOfHeader: fullyVisibleIndexPaths)
            return
        }
        
        switch fullyVisibleIndexPaths {
        case neededIndexPath.row:
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false){ [self] _ in
                isSelectingCategory = false
            }
        case 4:
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false){ [self] _ in
                isSelectingCategory = false
            }
        default:
            break
        }
    }
}



//MARK: - ScrollToRowDetegateFromCollectionViewToTableView
extension MenuVC: ScrollToRowDetegateFromCollectionViewToTableView{
    func sendRowToTableView(_ row: Int, isSelectingCategory: Bool) {
        switch row {
        case 0:
            DispatchQueue.main.async {
                self.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
            }
        default:
            neededIndexPath = IndexPath(row: 0, section: row + 1)
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: self.neededIndexPath, at: .centeredVertically, animated: true)
            }
        }
        self.isSelectingCategory = isSelectingCategory
    }
    
}
