//
//  CardSlideShowView.swift
//  Kappa
//
//  Created by Nima on 10/15/17.
//  Copyright © 2017 Nima. All rights reserved.
//

import UIKit

class CardSlideShowView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(SlideShowCell.self, forCellWithReuseIdentifier: CellID.SLIDE_SHOW)
        view.backgroundColor = .clear
        let edge = (UIScreen.main.bounds.width / 4) + 17.5
        view.contentInset = UIEdgeInsets(top: 0, left: edge, bottom: 0, right: edge)
        return view
    }()
    
    let indicator: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 10
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(hex: "AB2F63").withAlphaComponent(0.5)
        pageControl.currentPageIndicatorTintColor = UIColor(hex: "AB2F63")
        return pageControl
    }()
    
    var margin = (UIScreen.main.bounds.width / 4) + 17.5
    var width = (UIScreen.main.bounds.width - 70) / 2
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubview(collectionView)
        addSubview(indicator)
        addConstraints(with: "H:|[v0]|", views: collectionView)
        addConstraints(with: "H:|[v0]|", views: indicator)
        addConstraints(with: "V:|-15-[v0(85)][v1]|", views: collectionView, indicator)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.SLIDE_SHOW, for: indexPath) as? SlideShowCell{
            cell.img.image = UIImage(named: CardName.random)
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 35
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let guess = (scrollView.contentOffset.x + (margin + 1)) / (width + 35)
        indicator.currentPage = Int(round(guess))
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let guess = Int(round((scrollView.contentOffset.x + (margin + 1)) / (width + 35)))
        collectionView.scrollToItem(at: IndexPath(item: guess, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally , animated: true)
    }
}

class SlideShowCell: UICollectionViewCell{
    
    var img: UIImageView = {
        let img = UIImageView(image: UIImage(named: CardName.random))
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubview(img)
        addConstraints(with: "H:|[v0]|", views: img)
        addConstraints(with: "V:|[v0]|", views: img)
    }
}
















