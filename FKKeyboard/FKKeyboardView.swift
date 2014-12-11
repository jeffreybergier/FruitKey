//
//  FKKeyboardView.swift
//  FruitKey
//
//  Created by Jeffrey Bergier on 10/29/14.
//  Copyright (c) 2014 Saturday Apps. All rights reserved.
//

import UIKit

class FKKeyboardView: UIView {

    @IBOutlet private weak var changeKeyboardButton: FKKeyboardKeyButton?
    @IBOutlet private weak var insertWatchKeyboardButton: FKKeyboardKeyButton?
    @IBOutlet private weak var insertTVKeyboardButton: FKKeyboardKeyButton?
    @IBOutlet private weak var insertPayKeyboardButton: FKKeyboardKeyButton?
    @IBOutlet private weak var insertAppleKeyboardButton: FKKeyboardKeyButton?

    weak var delegate:KeyboardViewController? {
        didSet {
            if let changeKeyboardButton = self.changeKeyboardButton {
                changeKeyboardButton.addTarget(self.delegate, action: "didTapChangeKeyboardButton:", forControlEvents: UIControlEvents.TouchUpInside)
            }
            if let insertWatchKeyboardButton = self.insertWatchKeyboardButton {
                insertWatchKeyboardButton.addTarget(self.delegate, action: "didTapInsertWatchKeyboardButton:", forControlEvents: UIControlEvents.TouchUpInside)
            }
            if let insertTVKeyboardButton = self.insertTVKeyboardButton {
                insertTVKeyboardButton.addTarget(self.delegate, action: "didTapInsertTVKeyboardButton:", forControlEvents: UIControlEvents.TouchUpInside)
            }
            if let insertPayKeyboardButton = self.insertPayKeyboardButton {
                insertPayKeyboardButton.addTarget(self.delegate, action: "didTapInsertPayKeyboardButton:", forControlEvents: UIControlEvents.TouchUpInside)
            }
            if let insertAppleKeyboardButton = self.insertAppleKeyboardButton {
                insertAppleKeyboardButton.addTarget(self.delegate, action: "didTapInsertAppleKeyboardButton:", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var imageString = "globeIcon"
        //if an ipad, use a different image
        if UIScreen.mainScreen().bounds.size.height > UIScreen.mainScreen().bounds.size.width {
            if UIScreen.mainScreen().bounds.size.width > 767 {
                imageString = "iPadGlobeIcon"
            }
        } else {
            if UIScreen.mainScreen().bounds.size.height > 767 {
                imageString = "iPadGlobeIcon"
            }
        }
        var globeImage = UIImage(named: imageString)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.changeKeyboardButton?.setTitle("", forState: UIControlState.Normal)
        self.changeKeyboardButton?.imageView?.contentMode = UIViewContentMode.Center
        self.changeKeyboardButton?.setImage(globeImage, forState: UIControlState.Normal)
    }
}
