//
//  Theme.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 04/11/2021.
//

import UIKit

extension UIFont {
    static let logoFont = UIFont(name: "Museo Sans Cyrl", size: 28) ?? UIFont.systemFont(ofSize: 28)
    static let regularBold = UIFont(name: "OpenSans-SemiBold", size: 15) ?? UIFont.systemFont(ofSize: 15)
    static let regularSmall = UIFont(name: "OpenSans-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
    static let regularHeader = UIFont(name: "OpenSans-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16)
}

extension UIColor {
    static let mainOrange = UIColor(rgb: 0xF68F54)
    static let mainGray = UIColor(rgb: 0x939DAE)
    static let mainBackground = UIColor(rgb: 0xF7F7F7)
}

extension UINavigationBar {
    static func applyNavBarStyles() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainOrange,
                                          NSAttributedString.Key.font: UIFont.logoFont,
                                          NSAttributedString.Key.kern: -2]

        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

extension UITabBar {
    static func applyTabBarStyles() {
        UITabBar.appearance().tintColor = .mainOrange
        UITabBar.appearance().unselectedItemTintColor = .mainGray
        UITabBar.appearance().backgroundColor = .white
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
