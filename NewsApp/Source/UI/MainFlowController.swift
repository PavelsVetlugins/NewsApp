//
//  MainFlowController.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 03/11/2021.
//

import UIKit

public protocol FlowController: AnyObject {
    static var flowId: String { get }
}

public extension FlowController {
    static var flowId: String {
        return String(describing: self)
    }
}

public final class MainFlowController: FlowController {
    public static let shared = MainFlowController()

    public var childFlows: [String: FlowController] = [:]
    public var window: UIWindow!
    public var rootNC: UINavigationController!
    public var mainFlowFactory: MainVCFactoryProtocol!
    public var tabBarFlowFactory: TabBarVCFactoryProtocol!

    func setFactories(window: UIWindow?, mainFlowFactory: MainVCFactoryProtocol = MaincVCFactory(), tabBarFlowFactory: TabBarVCFactoryProtocol = TabBarVCFactory()) {
        self.window = window
        self.mainFlowFactory = mainFlowFactory
        self.tabBarFlowFactory = tabBarFlowFactory
    }

    public func start() {
        rootNC = window.rootViewController as! UINavigationController
        let tabBar = mainFlowFactory.tabBar()

        let home = tabBarFlowFactory.home()
        let news = tabBarFlowFactory.news()
        let search = tabBarFlowFactory.search()
        let profile = tabBarFlowFactory.profile()
        let more = tabBarFlowFactory.more()

        newsFlow = NewsFlowController()

        tabBar.viewControllers = [home, news, search, profile, more]
        rootNC.setViewControllers([tabBar], animated: false)

    }
}
