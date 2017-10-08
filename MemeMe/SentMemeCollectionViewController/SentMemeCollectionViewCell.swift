//
//  SentMemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Lester Batres on 10/1/17.
//  Copyright © 2017 Lester Batres. All rights reserved.
//

import UIKit

class SentMemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    private let memeTextAttributes: [String: Any] = [NSStrokeColorAttributeName: UIColor.black,
                                                     NSForegroundColorAttributeName: UIColor.white,
                                                     NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 14) ?? UIFont(),
                                                     NSStrokeWidthAttributeName: -1.0]
    
    static var identifier = "sentMemeCollectionViewCellIdentifier"
    
    func configureCellWith(_ meme: Meme) {
        memeImageView.image = meme.originalImage
        topLabel.attributedText = NSAttributedString(string: meme.topText, attributes: memeTextAttributes)
        bottomLabel.attributedText = NSAttributedString(string: meme.bottomText, attributes: memeTextAttributes)
    }
}
