//
//  ViewController.swift
//  Lessons
//
//  Created by Kamila on 7/21/19.
//  Copyright © 2019 Kamila. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userDefaulst = UserDefaults.standard
    
    let stackView = UIStackView()
    let alertButton = ActionButton(title: "Alert")
    let actionSheetButton = ActionButton(title: "Action sheet")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        title = "AlertView"
//        saveUserDefaults()
//        getFromUserDefaults()
        setupButtons()
    }
    
    private func setupButtons() {
        view.addSubview(stackView)
        stackView.frame = CGRect(x: 16, y: 300, width: 343, height: 100)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(alertButton)
        stackView.addArrangedSubview(actionSheetButton)
        
        alertButton.addTarget(self, action: #selector(didTapToAlertButton), for: .touchUpInside)
        actionSheetButton.addTarget(self, action: #selector(didTapToActionSheetButton), for: .touchUpInside)
    }
    
    @objc func didTapToAlertButton() {
        let alertViewController = UIAlertController(title: "Alert", message: "hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "First action", style: .default, handler: { _ in
            let textField = alertViewController.textFields?.first
            debugPrint("First action", textField?.text)
        })
        
        alertViewController.addTextField { textField in

        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertViewController.addAction(action)
        alertViewController.addAction(cancel)
        
        present(alertViewController, animated: true, completion: nil)
    }
    
    @objc func didTapToActionSheetButton() {
        let actionSheetViewController = UIAlertController(title: "Alert", message: "hello", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "First action", style: .default, handler: { _ in
            debugPrint("First action")
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheetViewController.addAction(action)
        actionSheetViewController.addAction(cancel)
        
        present(actionSheetViewController, animated: true, completion: nil)
    }
    
    func saveUserDefaults() {
        userDefaulst.set("Kamila", forKey: "name")
        userDefaulst.set(true, forKey: "gender")
        userDefaulst.set(13, forKey: "age")
    }
    
    func getFromUserDefaults() {
        if let name = userDefaulst.object(forKey: "name") {
            debugPrint("Name", name)
        }
        
        if let gender = userDefaulst.object(forKey: "gender") {
            debugPrint("Gender", gender)
        }
        
        if let age = userDefaulst.object(forKey: "age") {
            debugPrint("Age", age)
        }
    }
}

