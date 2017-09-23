//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Lester Batres on 9/14/17.
//  Copyright © 2017 Lester Batres. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {
    
    @IBOutlet weak var imageImgeView: UIImageView!
    @IBOutlet weak var pickFromLibraryButton: UIBarButtonItem!
    @IBOutlet weak var pickFromCameraButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem! {
        didSet {
            shareButton.isEnabled = false
        }
    }
    
    @IBOutlet weak var topTextField: UITextField! {
        didSet {
            topTextField.defaultTextAttributes = memeTextAttributes
            topTextField.autocapitalizationType = .allCharacters
            topTextField.textAlignment = .center
        }
    }
    
    @IBOutlet weak var bottomTextField: UITextField! {
        didSet {
            bottomTextField.defaultTextAttributes = memeTextAttributes
            bottomTextField.autocapitalizationType = .allCharacters
            bottomTextField.textAlignment = .center
        }
    }
    
    private let memeTextAttributes: [String: Any] = [NSStrokeColorAttributeName: UIColor.black,
                                                     NSForegroundColorAttributeName: UIColor.white,
                                                     NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40) ?? UIFont(),
                                                     NSStrokeWidthAttributeName: 1.0]
    
    
    // MARK: Lifecycle methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //subscribeToKeyboardNotifications()
        pickFromCameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK: IBAction methods
    
    @IBAction func didTapPickAnImageFromAlbum(_ sender: UIBarButtonItem) {
        pickAnImage(sourceType: .photoLibrary)
    }
    
    @IBAction func didTapPickAnImageFromCamera(_ sender: UIBarButtonItem) {
        pickAnImage(sourceType: .camera)
    }
    
    @IBAction func didTapShareButton(_ sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            self.saveMeme()
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    // MARK: Private methods
    
    private func pickAnImage(sourceType: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        
        present(pickerController, animated: true)
    }
    
    private func saveMeme() {
        let _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageImgeView.image!, memedImage: UIImage())
    }
    
    private func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    
    // MARK: Notification methods
    
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    // MARK: Keyboard methods
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}


// MARK: UIImagePickerControllerDelegate methods

extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageImgeView.image = image
            shareButton.isEnabled = true
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


// MARK: UITextField delegate methods

extension MemeEditorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
