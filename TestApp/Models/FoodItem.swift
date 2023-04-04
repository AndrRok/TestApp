//
//  FoodItem.swift
//  TestApp
//
//  Created by ARMBP on 4/4/23.
//

import Foundation

struct Food: Codable {
    let name: String
    let price: Int
    let description: String
    let foodType: String
    let image: String
}
