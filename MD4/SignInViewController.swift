//
//  SignInViewController.swift
//  MD4
//
//  Created by Students on 12/06/2020.
//  Copyright © 2020 KristapsNaglis. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var inputUsername: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var loginStatus: UILabel!
    
    var testUsername: String!
    var testPassword: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginStatus.text = ""
        testUsername = "kristaps"
        testPassword = "gribu-but-ios-devel"
    }

    @IBAction func submitLogin(_ sender: Any) {
        if (inputUsername.text == testUsername && inputPassword.text == testPassword) {
            print("Login succesful")
            self.performSegue(withIdentifier: "ToMainViewModal", sender: self)
        } else {
            print("Login failed")
            loginStatus.text = "LOGIN FAILED"
        }
    }
}
