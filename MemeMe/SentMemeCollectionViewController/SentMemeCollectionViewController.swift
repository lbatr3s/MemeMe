//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Lester Batres on 10/1/17.
//  Copyright © 2017 Lester Batres. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UICollectionViewController, ShowsEditor {
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    fileprivate var memes: [Meme] {
        return appDelegate.memes
    }

    var selector = #selector(showMemeEditor)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addCreateMemeButton()
        setupFlowLayout()
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
    
    
    // MARK: Private methods
    
    private func setupFlowLayout() {
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        collectionViewFlowLayout.minimumInteritemSpacing = space
        collectionViewFlowLayout.minimumLineSpacing = space
        collectionViewFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
}


// MARK: UICollectionViewDataSource

extension SentMemeCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SentMemeCollectionViewCell.identifier, for: indexPath) as! SentMemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
}


// MARK: UICollectionViewDelegate

extension SentMemeCollectionViewController {
    
}


// MARK: MemeEditorViewControllerDelegate methods

extension SentMemeCollectionViewController: MemeEditorViewControllerDelegate {
    
    func didFinishGeneratingMeme(controller: MemeEditorViewController, meme: Meme) {
        controller.dismiss(animated: true)
        collectionView?.reloadData()
    }
    
    func didCancelGeneratingMeme(controller: MemeEditorViewController) {
        controller.dismiss(animated: true)
    }
}
