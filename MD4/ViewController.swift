//
//  ViewController.swift
//  MD4
//
//  Created by Students on 12/06/2020.
//  Copyright © 2020 KristapsNaglis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "user_name"
        companyLabel.text = "user_company"
        bioLabel.text = "user_bio"
        
        fetchGithubUserData()
        getDocumentsDirectory()
    }
    
    
    func fetchGithubUserData(){
        let url = URL(string: "https://api.github.com/users/ioslekcijas")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: urlRequest){(data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let gitHubUser = try? decoder.decode(GitHubUser.self, from: data) {
                    DispatchQueue.main.async {
                        self.updateUserInterface(with: gitHubUser)
                    }
                } else {
                    print(error?.localizedDescription ?? "")
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchGithubUserRepoFiles(){
        let url = URL(string: "https://api.github.com/repos/ioslekcijas/faili/contents/")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: urlRequest){(data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let gitHubUserRepoFiles = try? decoder.decode(RepoFiles.self, from: data) {
                    self.downloadRepoContents(with: gitHubUserRepoFiles)
                } else {
                    print(error?.localizedDescription ?? "")
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    
    func downloadRepoContents(with userRepoFiles: RepoFiles){

        let fileCount = userRepoFiles.count
        var succesfulFileDownloads = 0

        for file in 0...fileCount - 1 {
            // Create destination URL
            let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
            let destinationFileUrl = documentsUrl.appendingPathComponent(userRepoFiles[file].name ?? "")

            //Create URL to the source file you want to download
            let fileURL = URL(string: userRepoFiles[0].downloadURL ?? "")

            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)

            let request = URLRequest(url:fileURL!)

            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
               if let tempLocalUrl = tempLocalUrl, error == nil {
                   // Success
                   if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                       print("Successfully downloaded. Status code: \(statusCode)")
                        succesfulFileDownloads += 1
                   }

                   do {
                       try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                   } catch (let writeError) {
                       print("Error creating a file \(destinationFileUrl) : \(writeError)")
                   }

               } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription ?? "Error happened while downloading file");
               }
            }
            task.resume()
    }
        
    }
    
    func getDocumentsDirectory(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDir = paths.firstObject as! String
        print("Path to the Documents directory\n\(documentsDir)")
    }
    
    func updateUserInterface(with user: GitHubUser) {
        self.nameLabel.text = user.name
        self.companyLabel.text = user.company
        self.bioLabel.text = user.bio
        self.imageView.downloaded(from: user.avatarURL ?? "https://dummyimage.com/350x350/8f8f8f/fff&text=profilepicture")
    }

    @IBAction func downloadGitRepoFiles(_ sender: Any) {
        fetchGithubUserRepoFiles()
    }
    
}

