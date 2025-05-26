//
//  NetworkLogger.swift
//  MutualFundSDK
//
//  Created by Darshan Mothreja on 11/12/20.
//  Copyright © 2019 Darshan. All rights reserved.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }

        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)

        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"

        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }

        print(logOutput)
    }
    
    static func log(response: URLResponse?, data: Data?) {
        print("\n - - - - - - - - - - Server Response - - - - - - - - - - \n")

        if let serverResponse = response, let httpResponse = serverResponse as? HTTPURLResponse {

            print("Validating request: \(String(describing: serverResponse.url?.absoluteString)) with HTTP status code: \(httpResponse.statusCode)")
        }
        if let jsonData = data, let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any] {

            print(json)
        }
        if let jsonData = data, let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [[String: Any]] {

            print(json)
        }
    }
}
