//
//  ChangeUsernameViewController.swift
//  MD4
//
//  Created by Students on 14/06/2020.
//  Copyright © 2020 KristapsNaglis. All rights reserved.
//

import UIKit

class ChangeUsernameViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func changeUsername(_ sender: Any) {
        // gitHubUsername = username.text ?? "ioslekcijas"
        Variables.gitHubUsername = username.text ?? "ioslekcijas"
        print(Variables.gitHubUsername)
    }
}

