//
//  HTTPService.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 11/11/2021.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

extension String: Error {}

class HTTPService {

    func fetchHeadlines() -> Observable<HeadlineModel> {
        return Observable.create { (observer) -> Disposable in
            let request = HeadlineRequest().asURLRequest()

            AF.request(request).response { response in
                if let headlineResponse = try? JSONDecoder().decode(HeadlineModel.self, from: response.data!) {
                    observer.onNext(headlineResponse)
                    observer.onCompleted()
                } else {
                    observer.onError("Request error \(String(describing: response.error))")
                }
            }
            return Disposables.create()
        }
    }

}
