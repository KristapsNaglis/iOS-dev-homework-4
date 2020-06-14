//
//  PhotosDetailViewController.swift
//  MD4
//
//  Created by Students on 14/06/2020.
//  Copyright © 2020 KristapsNaglis. All rights reserved.
//

import UIKit

class PhotosDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var currentContent: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let validName = currentContent {
            // 18:55
            let path = FileManager.documentsDir() + "/" + validName + ".jpg"
            print("Opening file path: " + path)
            let url = URL(fileURLWithPath: path)
            
            
            self.imageView.image = UIImage(imageLiteralResourceName: path)
        }
        
        
    }
    
}
