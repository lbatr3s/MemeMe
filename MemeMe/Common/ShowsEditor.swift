//
//  ShowsEditor.swift
//  MemeMe
//
//  Created by Lester Batres on 10/1/17.
//  Copyright © 2017 Lester Batres. All rights reserved.
//

import UIKit

protocol ShowsEditor {
    
    var selector: Selector { get }
    
    func addCreateMemeButton()
}

extension ShowsEditor where Self:  UIViewController {
    
    func addCreateMemeButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: selector)
    }
}
