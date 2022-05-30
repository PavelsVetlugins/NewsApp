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
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    let model = NewsVM()
    let bag = DisposeBag()

    let viewDidLoadSubject = PublishSubject<Void>()
    let viewDidAppearSubject = PublishSubject<Void>()


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(NewsCellView.self)
        tableView.register(NewsHeader.self, forHeaderFooterViewReuseIdentifier: NewsHeader.identifier)
        tableView.rx.setDelegate(self).disposed(by: bag)

        configureUI()
        bindUI()

        viewDidLoadSubject.onNext(())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSubject.onNext(())
    }

    private func configureUI() {
        self.view.backgroundColor = .mainBackground
        self.tableView.backgroundColor = .mainBackground
        self.tableView.separatorStyle = .none
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        self.activityIndicator.isHidden = true
        self.activityIndicator.startAnimating()
        self.infoLabel.isHidden = true
    }

    private func bindUI() {

        //Will fire on view did Load but will ignore subsequent view will appear call.
        let fetchRequired = Observable.merge([viewDidLoadSubject, viewDidAppearSubject])
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)

        let fetchAction = fetchRequired
            .flatMap {
            self.model.fetchHeadlines()
                .handleUIError(stub: [])
            }
            .share()

        //Single source of truth for data source
        model.cachedHeadlines.asDriver()
            .drive(tableView.rx.items(cellIdentifier: NewsCellView.identifier, cellType: NewsCellView.self)) { _, model, cell in
                cell.configure(model: model)
            }
            .disposed(by: bag)

        //UI reaction on fetch actions
        let fetchIndicatorRequired = fetchRequired.filter { [weak self] _ in self?.model.cachedHeadlines.value.count ?? 0 == 0 }

        let running = Observable.merge(fetchIndicatorRequired.map { false }, fetchAction.map { _ in true })
            .asDriver(onErrorJustReturn: false)

        running
            .drive(activityIndicator.rx.isHidden)
            .disposed(by: bag)

        fetchAction.asDriver(onErrorJustReturn: [])
            .map{ $0.count > 0 }
            .drive(infoLabel.rx.isHidden)
            .disposed(by: bag)

        tableView.rx.modelSelected(Article.self).subscribe(onNext: { model in
            if let url = URL(string: model.url) {
                MainFlowController.shared.newsFlow?.showHeadlineWebView(url: url)
            }
        })
        .disposed(by: bag)
    }

    private func fetchHeadline() {

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

private extension PrimitiveSequence where Trait == SingleTrait {

    func handleUIError(stub: Element) -> PrimitiveSequence<Trait, Element> {
        return self.catch { err in
            //TODO: Handle error
            print("+++ error \(err)")
            return .just(stub)
        }
    }
}
