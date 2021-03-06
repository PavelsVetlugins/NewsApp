//
//  NewsVC.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 10/11/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsVC: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    let model = NewsVM()
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(NewsCellView.self)
        tableView.register(NewsHeader.self, forHeaderFooterViewReuseIdentifier: NewsHeader.identifier)
        tableView.rx.setDelegate(self).disposed(by: bag)

        configureUI()
        bindUI()
        model.fetchHeadlines()
    }

    private func configureUI() {
        self.view.backgroundColor = .mainBackground
        self.tableView.backgroundColor = .mainBackground
        self.tableView.separatorStyle = .none
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

    private func bindUI() {
        model.headlines.asDriver().drive(tableView.rx.items(cellIdentifier: NewsCellView.identifier, cellType: NewsCellView.self)) { _, model, cell in
            cell.configure(model: model)
        }.disposed(by: bag)

        tableView.rx.modelSelected(Article.self).subscribe(onNext: { model in
            if let url = URL(string: model.url) {
                MainFlowController.shared.newsFlow?.showHeadlineWebView(url: url)
            }
        }).disposed(by: bag)
    }
}

extension NewsVC: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsHeader.identifier)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }

}
