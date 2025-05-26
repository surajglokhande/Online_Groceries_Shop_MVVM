//
//  SuccessResponse.swift
//  MutualFundSDK
//
//  Created by Darshan Mothreja on 11/12/20.
//  Copyright © 2019 Darshan. All rights reserved.
//

import Foundation

struct SuccessResponse: Decodable {
    let success: Bool
    let error_code: String
    let error_message: String
}
