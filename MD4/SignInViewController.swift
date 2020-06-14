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
    
    var testUsername: String!
    var testPassword: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        testUsername = "kristaps"
        testPassword = "gribu-but-ios-devel"
    }

    @IBAction func submitLogin(_ sender: Any) {
        if (inputUsername.text == testUsername && inputPassword.text == testPassword) {
            print("Login succesful")
            self.performSegue(withIdentifier: "ToMainViewModal", sender: self)
        } else {
            print("Login failed")
            print("But log in anyway for test purpouses")
            self.performSegue(withIdentifier: "ToMainViewModal", sender: self)
        }
    }
}
