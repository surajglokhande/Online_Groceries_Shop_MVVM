//
//  Task.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande on 26/05/25.
//

import Foundation

struct Task: Identifiable, Hashable, Equatable {
    let id = UUID()
    let title: String
    let description: String
}
