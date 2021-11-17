//
//  NewsFlowController.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 13/11/2021.
//

import Foundation
import UIKit

extension MainFlowController {

    var newsFlow: NewsFlowController? {
        get {
            return childFlows[NewsFlowController.self.flowId] as? NewsFlowController
        }
        set {
            childFlows[NewsFlowController.self.flowId] = newValue
        }
    }
}

class NewsFlowController: FlowController {

    func showHeadlineWebView(url: URL) {
        guard let webViewVC = StoryboardFactory.mainWebView.instantiateInitial() as? MainWebView else {
            assertionFailure("Wrong VC type")
            return
        }
        webViewVC.url = url
        webViewVC.onClose = {
            webViewVC.dismiss(animated: true)
        }
        MainFlowController.shared.rootNC.present(webViewVC, animated: true)
    }
}
