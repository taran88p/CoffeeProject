//
//  Order.swift
//  CoffeeProject
//
//  Created by Pavel on 8/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

struct Product: Decodable {
    
    var image: String
    var price: Double
    var title: String
    var shortDescription: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case image
        case price
        case title
        case shortDescription
        case description
    }
}

struct  ProductListResponse: Decodable {
    
    var products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case products
    }
}

