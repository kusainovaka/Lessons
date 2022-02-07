//
//  URLReguestPage.swift
//  Lessons
//
//  Created by Kamila on 8/11/19.
//  Copyright © 2019 Kamila. All rights reserved.
//

import UIKit

class URLReguestPage: UIViewController {
    
    var tableView = UITableView()
    var service = Service()
    var array: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        layoutUI()
        setupTableView()
        getData()
    }
    
    func getData() {
        service.reguest { codabelData in
            self.array = codabelData
            self.tableView.reloadData()
            print(codabelData, "Fetch")
        }
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
}

extension URLReguestPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].title
        return cell
    }
}

