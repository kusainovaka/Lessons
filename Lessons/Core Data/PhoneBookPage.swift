//
//  PhoneBookPage.swift
//  Lessons
//
//  Created by Kamila on 8/4/19.
//  Copyright © 2019 Kamila. All rights reserved.
//

import UIKit
import CoreData

class PhoneBookPage: UIViewController {
    
    var tableView = UITableView()
    var names: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    func layoutUI() {
        view.addSubview(tableView)
        let bounds = UIScreen.main.bounds
        tableView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setupNavigationBar() {
        let rightBarItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addButtonAction))
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func addButtonAction() {
        addActionView()
    }
    
    func addActionView() {
        let alertController = UIAlertController(title: "Add phone", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Enter name", style: .default, handler: { action in
            let textField = alertController.textFields?.first
            guard let name = textField?.text else { return }
            print(name, "🤡🤡🤡🤡🤡")
            self.saveName(text: name)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension PhoneBookPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let model = names[indexPath.row]
            deleteData(with: model)
            updateData()
        }
        
        tableView.reloadData()
    }
}


private extension PhoneBookPage {
    
    func saveName(text: String) {
        // Get our database
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // Get model(Person)
        let person = Person(entity: Person().entity, insertInto: context)
        let personNameKey = "name"
        // Set data inton Person(for key "name")
        person.setValue(text, forKey: personNameKey)
        do {
            try context.save()
            names.append(person)
        } catch let error {
            debugPrint("Could not save", error)
        }
        
        self.tableView.reloadData()
    }
    
    func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let result = try context.fetch(Person.fetchRequest())
            names = result as! [Person]
        } catch let error {
            debugPrint("Could not save", error)
        }
    }
    
    func deleteData(with model: Person) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(model)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func updateData() {
        fetchData()
    }
}
