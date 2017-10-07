//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Lester Batres on 10/7/17.
//  Copyright © 2017 Lester Batres. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    static let segueIdentifier = "memeDetailSegueIdentifier"
    
    var meme: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeImageView.image = meme.memedImage
    }
}
