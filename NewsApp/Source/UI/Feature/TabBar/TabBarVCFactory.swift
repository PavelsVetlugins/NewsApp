//
//  TabBarVCFactory.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 03/11/2021.
//

import UIKit

public protocol TabBarVCFactoryProtocol {
    func home() -> UIViewController
    func news() -> UIViewController
    func search() -> UIViewController
    func profile() -> UIViewController
    func more() -> UIViewController
}

public struct TabBarVCFactory: TabBarVCFactoryProtocol {
    public func home() -> UIViewController {
        StoryboardFactory.home.instantiateInitial()
    }

    public func news() -> UIViewController {
        StoryboardFactory.news.instantiateInitial()
    }

    public func search() -> UIViewController {
        StoryboardFactory.search.instantiateInitial()
    }

    public func profile() -> UIViewController {
        StoryboardFactory.profile.instantiateInitial()
    }

    public func more() -> UIViewController {
        StoryboardFactory.more.instantiateInitial()
    }


}
