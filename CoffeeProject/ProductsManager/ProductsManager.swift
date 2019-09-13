//
//  OrdersManager.swift
//  CoffeeProject
//
//  Created by Pavel on 8/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

class ProductsManager: NSObject {
    
    typealias Success = ([Product]) -> Void
    typealias Failure = (Error) -> Void
    
    static func fetchProductsWithCompleted(success: @escaping Success, failure: @escaping Failure) {
        DispatchQueue.global(qos: .background).async {
            if let path = Bundle.main.url(forResource: "products", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: path)
                    let productsArray = ProductsResponse.parse(data: data)
                    success(productsArray)
                } catch let error {
                    failure(error)
                }
            }
        }
    }
}
