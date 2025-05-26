//
//  HTTPTask.swift
//  MutualFundSDK
//
//  Created by Darshan Mothreja on 11/12/20.
//  Copyright © 2019 Darshan. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String:String]

enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: HTTPParameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: HTTPParameters?)
    
    case requestParametersAndHeaders(bodyParameters: HTTPParameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: HTTPParameters?,
        additionHeaders: HTTPHeaders?)
    
    case requestParametersWithImages(bodyParameters: HTTPParameters, media: [ MediaModel]?)
    
    // case download, upload...etc
}


