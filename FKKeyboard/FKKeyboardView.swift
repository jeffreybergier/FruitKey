//
// FKKeyboardView.swift
// FruitKey
//
// Created by Jeffrey Bergier on 10/29/14.
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Jeffrey Bergier
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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
