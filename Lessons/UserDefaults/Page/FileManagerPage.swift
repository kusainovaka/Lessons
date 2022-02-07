//
//  FileManagerPage.swift
//  Lessons
//
//  Created by Kamila on 10/6/19.
//  Copyright © 2019 Kamila. All rights reserved.
//

import UIKit

class FileManagerPage: UIViewController {
    
    var stackView = UIStackView()
    
    let fileManager = FileManager()
    let tempDir = NSTemporaryDirectory()
    let fileName = "file.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.frame = CGRect(x: 40, y: 100, width: 300, height: 400)
        
        let createButton = UIButton()
        createButton.backgroundColor = .blue
        createButton.setTitle("Create", for: .normal)
        createButton.addTarget(self, action: #selector(createAction), for: .touchUpInside)
        stackView.addArrangedSubview(createButton)
        
        let deleteButton = UIButton()
        deleteButton.backgroundColor = .blue
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        stackView.addArrangedSubview(deleteButton)
        
        let readButton = UIButton()
        readButton.backgroundColor = .blue
        readButton.setTitle("Read", for: .normal)
        readButton.addTarget(self, action: #selector(readAction), for: .touchUpInside)
        stackView.addArrangedSubview(readButton)
        
        let showButton = UIButton()
        showButton.backgroundColor = .blue
        showButton.setTitle("Show", for: .normal)
        showButton.addTarget(self, action: #selector(showAction), for: .touchUpInside)
        stackView.addArrangedSubview(showButton)
        
        let otherFolderButton = UIButton()
        otherFolderButton.backgroundColor = .blue
        otherFolderButton.setTitle("Other folder", for: .normal)
        otherFolderButton.addTarget(self, action: #selector(otherFolder), for: .touchUpInside)
        stackView.addArrangedSubview(otherFolderButton)
    }
    
    @objc private func createAction() {
        let path = (tempDir as NSString).appendingPathComponent(fileName)
        let contentsOfFile = "Some Text Here"
        
        do {
            try contentsOfFile.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            print("File text.txt created at temp directory")
        } catch let error {
            print("could't create file text.txt because of error: \(error)")
        }
    }
    
    @objc private func deleteAction() {
        let directoryWithFiles = checkDirectory() ?? "Empty"
        do {
            let path = (tempDir as NSString).appendingPathComponent(directoryWithFiles)
            try fileManager.removeItem(atPath: path)
            print("file deleted")
        } catch let error {
            print("error occured while deleting file: \(error.localizedDescription)")
        }
    }
    
    @objc private func readAction() {
        let directoryWithFiles = checkDirectory() ?? "Empty"
        
        let path = (tempDir as NSString).appendingPathComponent(directoryWithFiles)
        
        do {
            let contentsOfFile = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
            print("content of the file is: \(contentsOfFile)")
        } catch let error {
            print("there is an file reading error: \(error)")
        }
    }
    
    @objc private func showAction() {
        // Смотрим содержимое папки
        let directoryWithFiles = checkDirectory() ?? "Empty"
        print("Contents of Directory =  \(directoryWithFiles)")
    }
    
    func checkDirectory() -> String? {
        do {
            let filesInDirectory = try fileManager.contentsOfDirectory(atPath: tempDir)
            
            let files = filesInDirectory
            if files.count > 0 {
                if files.first == fileName {
                    print("file.txt found")
                    return files.first
                } else {
                    print("File not found")
                    return nil
                }
            }
        } catch let error{
            print(error)
        }
        return nil
    }
    
    
    @objc private func otherFolder() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            print(fileURLs)
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
}
