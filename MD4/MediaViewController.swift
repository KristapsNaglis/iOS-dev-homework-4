//
//  MediaViewController.swift
//  MD4
//
//  Created by Students on 13/06/2020.
//  Copyright © 2020 KristapsNaglis. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MediaViewController: UIViewController {

    var allFiles: [String] = []
    var playerController = AVPlayerViewController()
    
    @IBOutlet weak var mediaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mediaTableView.delegate = self
        mediaTableView.dataSource = self
        
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
            let mp3 = directoryContents.filter{$0.pathExtension == "mp3"}
            let mp4 = directoryContents.filter{$0.pathExtension == "mp4"}
            let files = mp3 + mp4
            // print("pdf urls:",pdfFiles)
            fileNames = files.map{ $0.deletingPathExtension().lastPathComponent }
            print("Media list:", fileNames)
            print(type(of: fileNames))
        
        } catch {
            print(error)
        }
        return fileNames
    }
}

extension MediaViewController: UITableViewDelegate, AVPlayerViewControllerDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me: " + FileManager.documentsDir() + "/" + allFiles[indexPath.row] + ".mp4")
        
        let path = FileManager.documentsDir() + "/" + allFiles[indexPath.row] + ".mp4"
        let videoURL = URL(string: path)
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: videoURL!)
        
        let playerViewController = AVPlayerViewController()
        // playerViewController.player = player

        present(playerViewController, animated: true) {
          player.play()
        }
        
        
    }
}

extension MediaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        
        cell.textLabel?.text = allFiles[indexPath.row]
        
        return cell
    }
}
