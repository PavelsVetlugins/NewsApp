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
        print("+++ send request")
        return Observable.create { (observer) -> Disposable in
            let request = HeadlineRequest().asURLRequest()

            AF.request(request).response { response in
                if let data = response.data, let headlineResponse = try? JSONDecoder().decode(HeadlineModel.self, from: data) {
                    observer.onNext(headlineResponse)
                    observer.onCompleted()
                } else {
                    let json = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String : Any]
                    observer.onError("Request error: Failed to decode \(HeadlineModel.self) from \(json)")
                }

                if response.error != nil {
                    observer.onError("Request error: \(response.error)")
                }
            }
            return Disposables.create()
        }
    }

}
