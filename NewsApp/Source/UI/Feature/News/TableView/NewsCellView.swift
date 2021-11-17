//
//  NewsCell.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 10/11/2021.
//

import Foundation
import UIKit
import Kingfisher

class NewsCellView: UITableViewCell {

    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .regularBold
        subTitleLabel.font = .regularSmall
        backgroundColor = .clear
    }

    public func configure(model: Article) {
        titleLabel.text = model.title
        subTitleLabel.text = model.articleDescription
        let imgUrl = URL(string: model.image)
        newsImage.kf.setImage(with: imgUrl)
    }
}
