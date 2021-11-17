//
//  StoryboardFactory.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 03/11/2021.
//

import UIKit

extension UIViewController {
    public class var identifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    public func instantiate<VC: UIViewController>() -> VC {
        guard let viewController = self.instantiateViewController(withIdentifier: VC.identifier) as? VC else {
            fatalError("Couldn't instantiate \(String(describing: VC.self))")
        }
        return viewController
    }
}


public enum StoryboardFactory: String {
    case mainTabBar = "MainTabBar"
    case home = "Home"
    case news = "News"
    case search = "Search"
    case profile = "Profile"
    case more = "More"
    case mainWebView = "MainWebView"

    public func storyboard(bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: bundle)
    }

    public func instantiateInitial<VC: UIViewController>(_ viewController: VC.Type=VC.self, inBundle bundle: Bundle? = nil) -> VC {
        let storyboard = self.storyboard(bundle: bundle)

        guard let viewController = storyboard.instantiateInitialViewController() as? VC else {
            fatalError("Couldn't instantiate \(String(describing: VC.self)) from \(self.rawValue)")
        }
        return viewController
    }
}



