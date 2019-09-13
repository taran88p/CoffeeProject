//
//  LoginView.swift
//  CoffeeProject
//
//  Created by Pavel on 8/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class LoginContentView: UIView {

    //MARK: - Outlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Variables
        
    var canBeFilled: Bool {
        return isUserNameEmpty && isPasswordEmpty
    }
    
    var isUserNameEmpty: Bool {
        if let text = userNameTextField.text {
            return !text.isEmpty
        }
        return false
    }
    
    var isPasswordEmpty: Bool {
        if let text = passwordTextField.text {
            return !text.isEmpty
        }
        return false
    }
}
