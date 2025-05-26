//
//  EndPoint.swift
//  MutualFundSDK
//
//  Created by Darshan Mothreja on 11/12/20.
//  Copyright © 2019 Darshan. All rights reserved.
//

import Foundation

fileprivate extension String {
    static var contentType = "Content-Type"
    static var multipart = "multipart/form-data; boundary=mediaBoundary"
    static var applicationJson = "application/json"
    static var authorizationHeader = "Authorization"
    static var userAgent = "User-Agent"
    static var apiOSTypeHeader = "OS-Type"
    
    static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}

enum RequestContentType: String {
    case none
    case applicationJson
    case multipart
}

protocol CommonHeaders {
    var authorizationRequired: Bool { get }
    var contentType: RequestContentType { get }
    var commonHeaders: [String: String]? { get }
}

extension CommonHeaders {
    
    var commonHeaders: [String: String]? {
        var headers: [String: String] = [:]
        
        switch contentType {
        case .applicationJson:
            headers[.contentType] = .applicationJson
        case .multipart:
            headers[.contentType] = .multipart
        default:
            break
        }
        
        return headers
    }
}


protocol EndPointType: CommonHeaders {
    var environmentBaseURL: String { get }
    var baseURL: URL { get }
    var path: String { get }
    var task: HTTPTask { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    static var domainURL: String { get }
}

extension EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        //case .dev: return "https://bfsd.dev.bfsgodirect.com/mf"
        case .qa:  return "https://bfl.bfldev.bfsgodirect.com/mf"
        case .uat:  return "https://bfl.bfldev.bfsgodirect.com/mf"
        case .prod: return "https://apis-marketplace.bajajfinserv.in/mf"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    static var domainURL: String {
        switch NetworkManager.environment {
        //case .dev: return "https://bfsd.dev.bfsgodirect.com"
        case .qa:  return "https://bfl.bfldev.bfsgodirect.com"
        case .uat:  return "https://bfl.bfldev.bfsgodirect.com"
        case .prod: return "https://apis-marketplace.bajajfinserv.in"
            //"http://mfbfsd.dev.bfsgodirect.com/app/api/"
        }
    }
    
    var headers: [String: String]? {
        return commonHeaders
    }
    
    var authorizationRequired: Bool {
        return true
    }
    
    var contentType: RequestContentType {
        return .applicationJson
    }
      
}
