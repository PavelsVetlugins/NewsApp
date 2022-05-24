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

//    let bag = DisposeBag()

//    let headlines: BehaviorRelay<[Article]> = BehaviorRelay(value: [])

    func fetchHeadlines() -> Observable<[Article]> {
        return HTTPService().fetchHeadlines().map{$0.articles}
//            .bind(to: headlines).disposed(by: bag)
    }
}
