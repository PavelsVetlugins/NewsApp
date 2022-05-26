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

    func fetchHeadlines() -> Single<HeadlineModel> {
        print("+++ send request")
        return Single.create { (observer) -> Disposable in
            let request = HeadlineRequest().asURLRequest()

            AF.request(request).response { response in
                if let data = response.data, let headlineResponse = try? JSONDecoder().decode(HeadlineModel.self, from: data) {
                    observer(.success(headlineResponse))
                } else {
                    let json = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String : Any]
                    observer(.failure("Request error: Failed to decode \(HeadlineModel.self) from \(json)"))
                }
                if response.error != nil {
                    observer(.failure("Request error: \(response.error)"))
                }
            }
            return Disposables.create()
        }
    }

}
