//
//  HomeViewController.swift
//  Kappa
//
//  Created by Nima on 10/15/17.
//  Copyright © 2017 Nima. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let cardSlideShow: CardSlideShowView = {
        let view = CardSlideShowView()
        return view
    }()
    
    let cardCollectionView: CardCollectionView = {
        let view = CardCollectionView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        self.view.addSubview(cardSlideShow)
        self.view.addSubview(cardCollectionView)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addConstraints(with: "H:|[v0]|", views: cardSlideShow)
        self.view.addConstraints(with: "H:|[v0]|", views: cardCollectionView)
        let margin = (navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        self.view.addConstraints(with: "V:|-\(margin)-[v0(120)]-20-[v1]|", views: cardSlideShow, cardCollectionView)
        setupNavBar()
    }
    
    func setupNavBar(){
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        title.text = "BizCard"
        title.textColor = UIColor(hex: "1E1E1E")
        title.textAlignment = .center
        title.font = title.font.withSize(20)
        navigationItem.titleView = title
        
        let searchImage = UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchTapped))
        navigationItem.leftBarButtonItem = searchBarButton
        
        let menuImage = UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal)
        let menuBarButton = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(menuTapped))
        navigationItem.rightBarButtonItem = menuBarButton
    }
    
    func searchTapped(){
        print("Launch Search Menu...")
    }
    
    func menuTapped(){
        print("Launch Menu...")
    }
}

class CardCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(CardCellView.self, forCellWithReuseIdentifier: CellID.HOME)
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 70, right: 0)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        addSubview(collectionView)
        addConstraints(with: "H:|[v0]|", views: collectionView)
        addConstraints(with: "V:|[v0]|", views: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.HOME, for: indexPath) as? CardCellView{
            cell.imgName = CardName.random
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 50, height: 110)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
}

class CardCellView: UICollectionViewCell{
    
    //Mark: Debuggig:
    var imgName: String = ""{
        didSet{
            img.image = UIImage(named: imgName)
        }
    }
    
    let img: UIImageView = {
        let img = UIImageView(image: UIImage(named: "Blue_Top"))
        return img
    }()
    
    let name: UILabel = {
        let view = UILabel()
        view.text = "Sara Radmanesh"
        view.textColor = UIColor(hex: "1E1E1E")
        view.font = view.font.withSize(13)
        return view
    }()
    
    let phoneNumber: UILabel = {
        let view = UILabel()
        view.text = "09365467812"
        view.textColor = UIColor(hex: "1E1E1E")
        view.font = view.font.withSize(11)
        return view
    }()
    
    let title: UILabel = {
        let view = UILabel()
        view.text = "Programmer"
        view.textColor = UIColor(hex: "1E1E1E")
        view.font = view.font.withSize(11)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        backgroundColor = .white
        setupShadow()
        
        
        addSubview(img)
        addSubview(name)
        addSubview(title)
        addSubview(phoneNumber)
        addConstraints(with: "H:|-20-[v0(140)]-12-[v1]|", views: img, name)
        addConstraints(with: "V:|-11.5-[v0]-11.5-|", views: img)
        
        addConstraint(NSLayoutConstraint(item: title, attribute: .left, relatedBy: .equal, toItem: name, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: title, attribute: .right, relatedBy: .equal, toItem: name, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: phoneNumber, attribute: .left, relatedBy: .equal, toItem: name, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: phoneNumber, attribute: .right, relatedBy: .equal, toItem: name, attribute: .right, multiplier: 1, constant: 0))
        addConstraints(with: "V:|-24-[v0(21)]-4.5-[v1(15.5)]-4.5-[v2(15.5)]", views: name, title, phoneNumber)
    }
    
    func setupShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
}


















