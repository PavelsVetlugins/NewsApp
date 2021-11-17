//
//  BaseNavigationController.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 04/11/2021.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        configureNavigationBarUI()
    }

    func configureNavigationBarUI() {
        if let existingView = navigationBar.subviews.first(where: { $0.accessibilityIdentifier == "customNavBarLayer" }) {
            existingView.removeFromSuperview()
        }

        let customView = UIView()
        customView.accessibilityIdentifier = "customNavBarLayer"
        var frame = self.navigationBar.bounds
        let statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        frame.size.height += statusBarHeight
        frame.origin.y -= statusBarHeight
        customView.frame = frame
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        customView.layer.zPosition = -1
        navigationBar.addSubview(customView)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: customView.bounds, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 20, height: frame.height)).cgPath

        shapeLayer.shadowColor = UIColor.lightGray.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 4.0)
        shapeLayer.shadowOpacity = 0.2
        shapeLayer.shadowRadius = 4
        shapeLayer.fillColor = UIColor.white.cgColor
        customView.layer.insertSublayer(shapeLayer, at: 0)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.configureNavigationBarUI()
         }

    }
}

extension UIApplication {

    var keyWindow: UIWindow? {
        return UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first
    }

}
