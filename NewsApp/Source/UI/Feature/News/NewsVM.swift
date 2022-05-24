//
//  NewsVM.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 12/11/2021.
//

import Foundation

import RxSwift
import RxCocoa

class NewsVM {

    let bag = DisposeBag()

    let cachedHeadlines: BehaviorRelay<[Article]> = BehaviorRelay(value: [])

    func fetchHeadlines() -> Observable<[Article]> {
        return HTTPService().fetchHeadlines()
            .map{$0.articles}
            .do(onNext: { self.cachedHeadlines.accept($0)})
                .catch({ err in
                    if self.cachedHeadlines.value.count > 0 {
                        print("+++ request failed, but return cached value")
                        return .just(self.cachedHeadlines.value)
                    } else {
                        throw err
                    }
                })
    }
}
