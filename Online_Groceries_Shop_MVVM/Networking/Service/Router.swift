//
//  NetworkService.swift
//  MutualFundSDK
//
//  Created by Darshan Mothreja on 11/12/20.
//  Copyright © 2019 Darshan. All rights reserved.
//

import Foundation

typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()
typealias NetworkRouterCompletionDownload = (_ response: URLResponse?,_ error: Error?)->()


protocol NetworkRouter: AnyObject {
    func request(_ route: EndPointType, completion: @escaping NetworkRouterCompletion)
    func requestPDFDownload(_ route: EndPointType, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPointType, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            #if DEBUG
            NetworkLogger.log(request: request)
            #endif
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                #if DEBUG
                NetworkLogger.log(response: response, data: data)
                #endif
                completion(data, response, error)
            })
        }catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func requestPDFDownload(_ route: EndPointType, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            #if DEBUG
            NetworkLogger.log(request: request)
            #endif
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                NetworkLogger.log(response: response, data: data)
                completion(data, response, error)
            })
        }catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPointType) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 60.0)
        addAdditionalHeaders(route.headers, request: &request)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                break
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            case .requestParametersWithImages(let bodyParameters, let mediaFiles):
                try self.configureParameters(bodyParameters: bodyParameters, bodyEncoding: .multipartEncoding, urlParameters: nil, request: &request, media: mediaFiles)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: HTTPParameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: HTTPParameters?,
                                         request: inout URLRequest, media: [MediaModel]? = nil) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters, media: media)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}

