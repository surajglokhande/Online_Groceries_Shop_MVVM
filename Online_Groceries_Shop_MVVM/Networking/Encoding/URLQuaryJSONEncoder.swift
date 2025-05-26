//
//  URLQuaryJSONEncoder.swift
//  MutualFundSDK
//
//  Created by Darshan Mothreja on 20/12/20.
//

import Foundation

struct URLQuaryJSONEncoder: ParameterEncoder {
    
    func encode(urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty else {
            throw NetworkError.missingURL
        }
        urlComponents.queryItems = parameters.map({URLQueryItem(name: $0.key, value: "\($0.value)")})
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
    }
}
