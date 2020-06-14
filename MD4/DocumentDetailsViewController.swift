//
//  DocumentDetailsViewController.swift
//  MD4
//
//  Created by Students on 13/06/2020.
//  Copyright © 2020 KristapsNaglis. All rights reserved.
//

import UIKit
import WebKit

class DocumentDetailsViewController: UIViewController {

    @IBOutlet weak var webKitView: WKWebView!
    var currentContent: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let validName = currentContent {
            // 18:55
            let path = FileManager.documentsDir() + "/" + validName + ".pdf"
            print("Opening file path: " + path)
            let url = URL(fileURLWithPath: path)
            webKitView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
}
