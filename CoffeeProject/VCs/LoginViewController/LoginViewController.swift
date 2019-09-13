//
//  ViewController.swift
//  CoffeeProject
//
//  Created by Pavel on 8/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

enum Message {
    static let warning = "Warning"
    static let emptyFeild = "Fields is empty"
    static let success = "Success"
    static let createdOrder = "Created Order"
    static let chooseCoffee = "Choose coffee"
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var contentView: LoginContentView!
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Other
    
    func checkEmptyField() -> Bool {
      return contentView.canBeFilled
    }
    
    func showAlert() {
        createAlert(title: Message.warning, message: Message.emptyFeild)
    }
    
    func showOrdersViewController() {
        let ordersVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrdersViewController")
        self.navigationController?.pushViewController(ordersVC, animated: true)
    }
    
    //MARK: - Action
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if checkEmptyField() {
            showOrdersViewController()
        } else {
            showAlert()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

