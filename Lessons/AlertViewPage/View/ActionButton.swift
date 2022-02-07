//
//  ActionButton.swift
//  Lessons
//
//  Created by Kamila on 7/21/19.
//  Copyright © 2019 Kamila. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = .green
        layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
