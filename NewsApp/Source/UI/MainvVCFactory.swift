//
//  MainFlowControllerFactory.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 03/11/2021.
//

import UIKit

public protocol MainVCFactoryProtocol {
    func tabBar() -> UITabBarController
}

public struct MaincVCFactory: MainVCFactoryProtocol {

    public func tabBar() -> UITabBarController {
        return StoryboardFactory.mainTabBar.instantiateInitial()
    }
}
