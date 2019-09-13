//
//  ProductResponse.swift
//  CoffeeProject
//
//  Created by Pavel on 8/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

class ProductsResponse {
    
    class func parse(data: Data) -> [Product] {
        let parsedResult = try! JSONDecoder().decode(ProductListResponse.self, from: data)
        return parsedResult.products
    }
}

