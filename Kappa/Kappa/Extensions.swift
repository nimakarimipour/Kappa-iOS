//
//  Extensions.swift
//  My Youtube
//
//  Created by Nima on 6/23/17.
//  Copyright © 2017 Nima. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    static func rgb(r: Float, g: Float, b: Float, alpha: Float) -> UIColor{
        return UIColor(red: CGFloat(r / 255), green: CGFloat(g / 255), blue: CGFloat(b / 255), alpha: CGFloat(alpha))
    }
}

extension UIView {
    func addConstraints(with format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UITabBarController{
    
    func hideTabBar(){
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        UIView.animate(withDuration: 0.5, animations: {
            self.tabBar.frame = CGRect(x: 0, y: height, width: width, height: self.tabBar.frame.height)
        }) { (completed) in
            self.tabBar.isHidden = true
        }
    }
    
    func showTabBar(){
        self.tabBar.isHidden = false
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let heightOfTabBar = self.tabBar.frame.height
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.tabBar.frame = CGRect(x: 0, y: height - heightOfTabBar, width: width, height: heightOfTabBar)
        }) { (completed) in
            self.tabBar.isHidden = false
        }
    }
}

extension UINavigationController{
    
    func hideNavigationBar(){
        let width = UIScreen.main.bounds.width
        UIView.animate(withDuration: 0.5, animations: {
            self.navigationBar.frame = CGRect(x: 0, y: -self.navigationBar.frame.height, width: width, height: self.navigationBar.frame.height)
        }) { (completed) in
            self.navigationBar.isHidden = true
        }
    }
    
    func showTabBar(){
        self.navigationBar.isHidden = false
        let width = UIScreen.main.bounds.width
        let heightOfTabBar = self.navigationBar.frame.height
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.navigationBar.frame = CGRect(x: 0, y: 0, width: width, height: heightOfTabBar)
        }) { (completed) in
            self.navigationBar.isHidden = false
        }
    }
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
    
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

extension UIViewController {
    
    var visibleViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.visibleViewController
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.visibleViewController
        } else if let presentedViewController = presentedViewController {
            return presentedViewController.visibleViewController
        } else {
            return self
        }
    }
}

extension UIApplication {
    
    static var topMostViewController: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController?.visibleViewController
    }
}




