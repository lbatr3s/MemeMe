//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Lester Batres on 10/1/17.
//  Copyright © 2017 Lester Batres. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController, ShowsEditor {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    fileprivate var memes: [Meme] {
        let memes = appDelegate.memes
        
        return memes
    }
    
    var selector = #selector(showMemeEditor)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sent Memes"
        addCreateMemeButton()
    }
    
    func showMemeEditor() {
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        
        if identifier == segueIdentifier {
            let navigationController = segue.destination as! UINavigationController
            let editorViewController = navigationController.viewControllers.first as? MemeEditorViewController
            editorViewController?.delegate = self
        }
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
        
        let meme = memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.topText)...\(meme.bottomText)"
        
        return cell
    }
}


// MemeEditorViewControllerDelegate methods

extension SentMemeTableViewController: MemeEditorViewControllerDelegate {
    
    func didFinishGeneratingMeme(controller: MemeEditorViewController, meme: Meme) {
        controller.dismiss(animated: true)
        tableView.reloadData()
    }
    
    func didCancelGeneratingMeme(controller: MemeEditorViewController) {
        controller.dismiss(animated: true)
    }
}
