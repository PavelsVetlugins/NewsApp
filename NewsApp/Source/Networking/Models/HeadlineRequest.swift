//
//  HeadlineRequest.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 12/11/2021.
//

import Foundation
import Alamofire

public protocol HttpRequest: Alamofire.URLRequestConvertible {

    var method: HTTPMethod { get }

    var url: URL? { get }

    var query: [URLQueryItem] { get }
}

extension HttpRequest {

    var baseUrl: String { "https://gnews.io" }

    var method: HTTPMethod {
        .get
    }

    var query: [URLQueryItem] { [] }

    public func asURLRequest() -> URLRequest {

        var urlComponent = URLComponents(url: url!, resolvingAgainstBaseURL: true)
        urlComponent?.queryItems = query

        var urlRequest = URLRequest(url: urlComponent!.url!)
        urlRequest.httpMethod = self.method.rawValue

        return urlRequest
    }
}


struct HeadlineRequest: HttpRequest {

    var url: URL? {
        let path = "/api/v4/top-headlines"
        return URL(string: path, relativeTo: URL(string: baseUrl))
    }

    var query: [URLQueryItem] {
        [URLQueryItem(name:"token", value: "d352f983f39b58d5a5585e7d795758db")]
    }

}
