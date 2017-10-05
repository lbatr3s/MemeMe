//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Lester Batres on 10/1/17.
//  Copyright © 2017 Lester Batres. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController, ShowsEditor {
    
    fileprivate let memes: [Meme] = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let memes = appDelegate.memes
        
        return memes
    }()
    
    var selector = #selector(showMemeEditor)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sent Memes"
        addCreateMemeButton()
    }
    
    func showMemeEditor() {
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
}


// MARK: - Table view methods

extension SentMemeTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SentMemeTableViewCell.identifier, for: indexPath) as! SentMemeTableViewCell
        
        return cell
    }
}
