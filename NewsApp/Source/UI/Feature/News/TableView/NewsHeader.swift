//
//  NewsHeader.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 11/11/2021.
//

import Foundation
import UIKit

class NewsHeader: UITableViewHeaderFooterView {

    let label = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = .regularHeader
        label.text = "News"

        self.contentView.addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
