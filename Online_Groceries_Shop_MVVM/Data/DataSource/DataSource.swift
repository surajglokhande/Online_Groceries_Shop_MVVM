//
//  DataSource.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande on 26/05/25.
//

import Foundation
import Combine

protocol DataSourceProtocol {
    func getModel<T: Decodable>() -> AnyPublisher<[T], Error>
}

