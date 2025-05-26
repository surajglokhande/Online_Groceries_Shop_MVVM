//
//  URLEncoding.swift
//  MutualFundSDK
//
//  Created by Darshan Mothreja on 11/12/20.
//  Copyright © 2019 Darshan. All rights reserved.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in parameters {
                if let arr = value as? [Any] {
                    for value in arr {
                        let queryItem = URLQueryItem(name: key,
                                                     value: "\(value)")
                        urlComponents.queryItems?.append(queryItem)
                    }
                } else {
                    let queryItem = URLQueryItem(name: key,
                                                 value: "\(value)")
                    urlComponents.queryItems?.append(queryItem)
                }
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
}
