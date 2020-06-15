//
//  Variables.swift
//  MD4
//
//  Created by Students on 14/06/2020.
//  Copyright © 2020 KristapsNaglis. All rights reserved.
//

import Foundation
struct Variables {
    static var gitHubUsername = "ioslekcijas"
}

func getGitHubUsername() -> String{
    return Variables.gitHubUsername
}

func setGitHubUsername(as name: String){
    Variables.gitHubUsername = name
}
