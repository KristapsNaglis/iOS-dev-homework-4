//
//  DocumentsViewController.swift
//  MD4
//
//  Created by Students on 13/06/2020.
//  Copyright © 2020 KristapsNaglis. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController{
    
    var allDocs: [String] = []
    var selectedContent: String = ""
    @IBOutlet weak var docsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        docsTableView.delegate = self
        docsTableView.dataSource = self
        
        allDocs = listAllDocuments()
    }
    
    func listAllDocuments() -> [String]{
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var docFileNames: [String] = []
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            print(directoryContents)
        
            // if you want to filter the directory contents you can do like this:
            let pdf = directoryContents.filter{$0.pathExtension == "pdf"}
            let docx = directoryContents.filter{$0.pathExtension == "docx"}
            let xlsx = directoryContents.filter{$0.pathExtension == "xlsx"}
            let pptx = directoryContents.filter{$0.pathExtension == "pptx"}
            
            let docFiles = pdf + docx + xlsx + pptx
            // print("pdf urls:",pdfFiles)
            docFileNames = docFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("Documents list:", docFileNames)
            print(type(of: docFileNames))
        
        } catch {
            print(error)
        }
        return docFileNames
    }
    
    
    @IBAction func refreshList(_ sender: Any) {
        DispatchQueue.main.async {
            self.docsTableView.reloadData()
        }
    }
    
}

extension DocumentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
        self.selectedContent = allDocs[indexPath.row]
        performSegue(withIdentifier: "DocumentCellIdentifier", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DocumentCellIdentifier") {
            let detailsViewController = segue.destination as! DocumentDetailsViewController
            detailsViewController.currentContent = self.selectedContent
        }
    }
    
    
}

extension DocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDocs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        
        cell.textLabel?.text = allDocs[indexPath.row]
        
        return cell
    }
}

extension FileManager {
    class func documentsDir() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
}
