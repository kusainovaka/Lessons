//
//  PresentImagePage.swift
//  Lessons
//
//  Created by Kamila on 10/6/19.
//  Copyright © 2019 Kamila. All rights reserved.
//

import UIKit

class PresentImagePage: UIViewController {
    
    private var imageView = UIImageView()
    private var actionButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        setupViews()
        saveData()
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        imageView.backgroundColor = .orange
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 80, y: 150, width: 300, height: 300)
        
        view.addSubview(actionButton)
        actionButton.backgroundColor = .red
        actionButton.setTitle("CLick", for: .normal)
        actionButton.frame = CGRect(x: 300, y: 500, width: 80, height: 80)
        actionButton.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
    }
    
    func saveData() {
        // Картинка уже есть в программе!!! с именем pugs
        guard let image = UIImage(named: "pugs") else { return }
        let imageData = image.jpegData(compressionQuality: 0.75)

        UserDefaults.standard.set(imageData, forKey: "savedImage")
    }
    
    @objc private func clickAction() {
        guard let data = UserDefaults.standard.data(forKey: "savedImage") else { return }
        imageView.image = UIImage(data: data)
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
