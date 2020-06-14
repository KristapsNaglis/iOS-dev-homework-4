//
//  PhotosViewController.swift
//  MD4
//
//  Created by Students on 13/06/2020.
//  Copyright © 2020 KristapsNaglis. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    var allFiles: [String] = []
    var selectedContent: String = ""
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        collectionView.collectionViewLayout = layout
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
       
        allFiles = listAllDocuments()
    }
    
    
    func listAllDocuments() -> [String]{
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var fileNames: [String] = []
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            print(directoryContents)
        
            // if you want to filter the directory contents you can do like this:
            let jpg = directoryContents.filter{$0.pathExtension == "jpg"}
            let files = jpg
            // print("pdf urls:",pdfFiles)
            fileNames = files.map{ $0.deletingPathExtension().lastPathComponent }
            print("Photos list:", fileNames)
            print(type(of: fileNames))
        
        } catch {
            print(error)
        }
        return fileNames
    }
}


extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("You tapped me")
        self.selectedContent = allFiles[indexPath.row]
        performSegue(withIdentifier: "showImageView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showImageView") {
            let detailsViewController = segue.destination as! PhotosDetailViewController
            detailsViewController.currentContent = self.selectedContent
        }
    }
    
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        
        for image in 0...allFiles.count - 1 {
            let currenntImage = FileManager.documentsDir() + "/" + allFiles[image] + ".jpg"

            cell.configure(with: UIImage(named: currenntImage)!)
        }
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
}
