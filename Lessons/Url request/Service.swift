//
//  Service.swift
//  Lessons
//
//  Created by Kamila on 8/11/19.
//  Copyright © 2019 Kamila. All rights reserved.
//

import Foundation
import UIKit

class Service {
    
    func reguest(complition: (([UserModel]) -> ())?) {
        let httpURL = URL(string: "https://jsonplaceholder.typicode.com/todos/")!
        let httpSession = URLSession.shared.dataTask(with: httpURL) { (data, response, error) in
            guard let validData = data, error == nil else {
                DispatchQueue.main.async {
                    print(error, "Error")
                }
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let codableData = try JSONDecoder().decode(UserModel.self, from: validData)
                    complition?([codableData])
                } catch let error {
                    print("Catch error", error.localizedDescription)
                }
            }
        }
        httpSession.resume()
    }
    
}
