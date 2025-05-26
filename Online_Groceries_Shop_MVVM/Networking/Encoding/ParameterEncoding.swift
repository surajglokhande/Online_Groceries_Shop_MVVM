//
//  ParameterEncoding.swift
//  MutualFundSDK
//
//  Created by Darshan Mothreja on 11/12/20.
//  Copyright © 2019 Darshan. All rights reserved.
//

import Foundation

typealias HTTPParameters = [String:Any]

protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: HTTPParameters) throws
    func encode(urlRequest: inout URLRequest, with parameters: HTTPParameters, media: [MediaModel]?) throws
}

extension ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: HTTPParameters, media: [MediaModel]?) throws {
        
    }
}

enum ParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    case urlQueryInBodyEncoding
    case multipartEncoding
    
    func encode(urlRequest: inout URLRequest,
                       bodyParameters: HTTPParameters?,
                       urlParameters: HTTPParameters?, media: [MediaModel]? = nil) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
           
            case .urlQueryInBodyEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try URLQuaryJSONEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            
            case .multipartEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try MultipartParameterEncoding().encode(urlRequest: &urlRequest, with: bodyParameters, media: media)
                
            }
        }catch {
            throw error
        }
    }
}


enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
