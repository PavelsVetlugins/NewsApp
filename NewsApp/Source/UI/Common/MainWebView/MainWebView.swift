//
//  MainWebView.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 13/11/2021.
//

import Foundation
import UIKit
import WebKit

class MainWebView: UIViewController {

    public var url: URL?
    public var onClose: (() -> Void)?

    @IBOutlet private weak var mainWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = self.url else {
            assertionFailure("Url not provided")
            return
        }

        let request = URLRequest(url: url)
        mainWebView.load(request)
    }

    @IBAction func closeTap(_ sender: Any) {
        self.onClose?()
    }
}
