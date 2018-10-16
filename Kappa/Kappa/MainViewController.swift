//
//  ViewController.swift
//  Kappa
//
//  Created by Nima on 10/15/17.
//  Copyright © 2017 Nima. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    // static let db = DBMS()
    
    let homeNavController: UINavigationController = {
        let controller = UINavigationController(rootViewController: HomeViewController())
        controller.tabBarItem.image = UIImage(named: "Home")
        return controller
    }()
    
    let addViewController: AddViewController = {
        let controller = AddViewController()
        controller.tabBarItem.image = UIImage(named: "Home")
        return controller
    }()
    
    let viewController2: AddViewController = {
        let controller = AddViewController()
        controller.tabBarItem.image = UIImage(named: "Home")
        return controller
    }()
    
    let viewController4: AddViewController = {
        let controller = AddViewController()
        controller.tabBarItem.image = UIImage(named: "Home")
        return controller
    }()
    
    let viewController5: AddViewController = {
        let controller = AddViewController()
        controller.tabBarItem.image = UIImage(named: "Home")
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUp()
    }
    
    func setUp(){
        self.viewControllers = [homeNavController, viewController2, addViewController, viewController4, viewController5]
        self.tabBar.tintColor = UIColor(hex: "AD3467")
        self.tabBar.unselectedItemTintColor = UIColor(hex: "545454")
    }
}












