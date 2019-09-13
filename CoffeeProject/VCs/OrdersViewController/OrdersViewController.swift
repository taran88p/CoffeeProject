//
//  OrdersViewController.swift
//  CoffeeProject
//
//  Created by Pavel on 8/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

enum StateCell {
    case colapsed
    case expanded
}

class OrdersViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet var ordersContentView: OrdersContentView!
    
    //MARK: - Variables
    
    var price = 0.0
    var selectedIndexPath: IndexPath?
    var stateCell: StateCell = .colapsed
    var dictionary = [Int : Double]()
    
    var productsArray = [Product]() {
        didSet {
            DispatchQueue.main.async {
               self.ordersContentView.ordersTableView.reloadData()
            }
        }
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProductsManager.fetchProductsWithCompleted(success: { (products) in
            self.productsArray = products
        }) { (error) in
            print("parse error: \(error.localizedDescription)")
        }
    }
}

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == productsArray.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.reuseID(), for: indexPath) as! OrderTableViewCell
            cell.delegate = self
            cell.configure(price: price)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseID(), for: indexPath) as! ProductTableViewCell
            var countCups: Double = 0.0
            if let totalPriceForCurrentCoffee = dictionary[indexPath.row] {
                 countCups = totalPriceForCurrentCoffee/productsArray[indexPath.row].price
            }
            cell.configure(product: productsArray[indexPath.row], index: indexPath.row, countCups: countCups)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == productsArray.count - 1 {
            return
        }
        
        if self.selectedIndexPath != indexPath && self.selectedIndexPath != nil {
            let cell = tableView.cellForRow(at: selectedIndexPath!) as! ProductTableViewCell
            cell.colapseCell()
            stateCell = .colapsed
        }
        
        switch stateCell {
        case .colapsed:
            let cell = tableView.cellForRow(at: indexPath) as! ProductTableViewCell
            var countCups: Double = 0.0
            if let totalPriceForCurrentCoffee = dictionary[indexPath.row] {
                countCups = totalPriceForCurrentCoffee/productsArray[indexPath.row].price
            }
            cell.expandCell(product: productsArray[indexPath.row], countCups: countCups)
            tableView.beginUpdates()
            tableView.endUpdates()
            stateCell = .expanded
            self.selectedIndexPath = indexPath
        case . expanded:
            let cell = tableView.cellForRow(at: indexPath) as! ProductTableViewCell
            cell.colapseCell()
            tableView.beginUpdates()
            tableView.endUpdates()
            stateCell = .colapsed
            self.selectedIndexPath = indexPath
        }
    }
}

extension OrdersViewController: ProductTableViewCellDelegate {
    func addedCoffeeToOrder(tag: Int, value: Double) {
        dictionary[tag] = value * productsArray[tag].price
        price = 0.0
        for product in dictionary {
            price += product.value
        }
        ordersContentView.ordersTableView.reloadData()
    }
}

extension OrdersViewController: OrderTableViewCellDelegate {
    func createOrder() {
        if price != 0.0 {
            price = 0.0
            createAlert(title: Message.success, message: Message.createdOrder)
            dictionary = [:]
            ordersContentView.ordersTableView.reloadData()
        } else {
            createAlert(title: nil, message: Message.chooseCoffee)
        }
    }
}
