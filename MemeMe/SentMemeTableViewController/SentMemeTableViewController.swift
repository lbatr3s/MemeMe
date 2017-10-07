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
    
    fileprivate var selectedMeme: Meme!
    
    var selector = #selector(showMemeEditor)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sent Memes"
        configureTableView()
        addCreateMemeButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func showMemeEditor() {
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        
        switch identifier {
        case segueIdentifier:
            let navigationController = segue.destination as! UINavigationController
            let editorViewController = navigationController.viewControllers.first as? MemeEditorViewController
            editorViewController?.delegate = self
        case MemeDetailViewController.segueIdentifier:
            let memeDetailViewController = segue.destination as! MemeDetailViewController
            memeDetailViewController.meme = selectedMeme
        default:
            break
        }
        
        if identifier == segueIdentifier {
        }
    }
    
    
    // MARK: Private methods
    
    private func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40.0
    }
    
    fileprivate func showMemeDetail() {
        performSegue(withIdentifier: MemeDetailViewController.segueIdentifier, sender: self)
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
        cell.memeImageView.image = meme.memedImage
        cell.memeLabel.text = "\(meme.topText)...\(meme.bottomText)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMeme = memes[indexPath.row]
        showMemeDetail()
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
