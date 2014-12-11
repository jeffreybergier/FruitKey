//
//  KeyboardViewController.swift
//  FKKeyboard
//
//  Created by Jeffrey Bergier on 10/29/14.
//  Copyright (c) 2014 Saturday Apps. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    private var keyboardView: FKKeyboardView?
    private weak var castedTextDocumentProxy: UITextDocumentProxy?
    private var keyboardHeight: CGFloat = 50.0
    private let IPHONE5KEYBOARDHEIGHT: CGFloat = 101.0
    private let IPHONE6KEYBOARDHEIGHT: CGFloat = 50.0
    private let IPADKEYBOARDHEIGHT: CGFloat = 71.0
    private let KEYBOARDGOAWAYTIMERINTERVAL = 0.0
    private let KEYBOARDGOINGAWAYANIMATIONDURATION = 0.2
    private let KEYBOARDKEYZOOMINGANIMATIONDURATION = 0.4
    private var heightConstraint: NSLayoutConstraint?

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //it should be easier to deal with this pre-casted textDocumentProxy
        self.castedTextDocumentProxy = self.textDocumentProxy as? UITextDocumentProxy
        
        //check screensize
        self.keyboardHeight = self.checkScreenSize()
        
        //create the view and add it to the view controller
        let nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("FKKeyboardView", owner: self, options: nil)
        var arrayIndex = 0
        for i in 0..<nibArray.count {
            let keyboardView = nibArray[i] as FKKeyboardView
            println(keyboardView.frame.size.height)
            if keyboardView.frame.size.height == self.keyboardHeight {
                arrayIndex = i
                break
            }
        }
        self.keyboardView = nibArray[arrayIndex] as? FKKeyboardView
        
        //check if this is an iPad
        if self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Regular && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Regular {
            self.keyboardHeight = self.IPADKEYBOARDHEIGHT
        }
        
        if let keyboardView = self.keyboardView {
            keyboardView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.view.addSubview(keyboardView)
            
            var keyboardViewLeftSideConstraint = NSLayoutConstraint(item: keyboardView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            var keyboardViewRightSideConstraint = NSLayoutConstraint(item: keyboardView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0.0)
            var keyboardViewTopConstraint = NSLayoutConstraint(item: keyboardView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0)
            var keyboardViewBottomConstraint = NSLayoutConstraint(item: keyboardView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
            
            self.view.addConstraints([keyboardViewLeftSideConstraint, keyboardViewRightSideConstraint, keyboardViewTopConstraint, keyboardViewBottomConstraint])

            keyboardView.delegate = self
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //set the height of the keyboard
        if let heightConstraint = self.heightConstraint {
            println("KeyboardViewController: The height constraint was already set on viewwillappear. This probably shouldn't happen")
        } else {
            let variable = self.keyboardHeight
            self.heightConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0.0, constant: self.keyboardHeight)
            self.view.addConstraint(self.heightConstraint!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        if let castedTextDocumentProxy = self.castedTextDocumentProxy {
            if castedTextDocumentProxy.keyboardAppearance == UIKeyboardAppearance.Dark {
                NSNotificationCenter.defaultCenter().postNotificationName("keyboardShouldBeDark", object: self)
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName("keyboardShouldBeLight", object: self)
            }
        }
    }
    
    
    //handle the button presses from the view
    func didTapChangeKeyboardButton(sender:FKKeyboardKeyButton) {
        self.advanceToNextInputMode()
    }
    
    func didTapInsertWatchKeyboardButton(sender:FKKeyboardKeyButton) {
        let stringToBeInserted = self.checkCurrentContext()
        self.castedTextDocumentProxy?.insertText(stringToBeInserted + "Watch ")
        self.animatedPressedButton(sender, AndStartTimer: true)
    }
    
    func didTapInsertTVKeyboardButton(sender:FKKeyboardKeyButton) {
        let stringToBeInserted = self.checkCurrentContext()
        self.castedTextDocumentProxy?.insertText(stringToBeInserted + "TV ")
        self.animatedPressedButton(sender, AndStartTimer: true)
    }
    
    func didTapInsertPayKeyboardButton(sender:FKKeyboardKeyButton) {
        let stringToBeInserted = self.checkCurrentContext()
        self.castedTextDocumentProxy?.insertText(stringToBeInserted + "Pay ")
        self.animatedPressedButton(sender, AndStartTimer: true)
    }
    
    func didTapInsertAppleKeyboardButton(sender:FKKeyboardKeyButton) {
        let stringToBeInserted = self.checkCurrentContext()
        self.castedTextDocumentProxy?.insertText(stringToBeInserted + "")
        self.animatedPressedButton(sender, AndStartTimer: true)
    }
    
    private func checkCurrentContext() -> String {
        var string = ""
        
        if let textDocumentProxy = self.castedTextDocumentProxy {
            let stringBeforeInput:NSString? = textDocumentProxy.documentContextBeforeInput
            //if this context before input is nil that means we're at the beginning of the line. No space is needed. The next optional unwrap will be skipped and we will return a blank string
            if let stringBeforeInput = stringBeforeInput {
                //if the string is not nil we need to figure out which character is there. If its a space, then we insert nothing. If its anything else, we insert a space.
                if stringBeforeInput.characterAtIndex(stringBeforeInput.length - 1) != 32 {
                    string = " "
                }
            }
        }
        
        return string
    }
    
    private func animatedPressedButton(sender: FKKeyboardKeyButton, AndStartTimer startTimer: Bool) {
        sender.superview?.bringSubviewToFront(sender)
        UIView.animateWithDuration(self.KEYBOARDKEYZOOMINGANIMATIONDURATION,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                sender.transform = CGAffineTransformScale(sender.transform, 2.0, 2.0)
                sender.alpha = 0.0
                sender.superview?.alpha = 1.0
            }, completion: { finished in
                if (startTimer) {
                    let timer = NSTimer.scheduledTimerWithTimeInterval(self.KEYBOARDGOAWAYTIMERINTERVAL, target: self, selector: "animateAwayKeyboardAndSwitchToNextKeyboard:", userInfo: nil, repeats: false)
                } else {
                    self.advanceToNextInputMode()
                }
        })
    }
    
    func animateAwayKeyboardAndSwitchToNextKeyboard(timer: NSTimer) {
        timer.invalidate()
        if let keyboardView = self.keyboardView {
            UIView.animateWithDuration(self.KEYBOARDGOINGAWAYANIMATIONDURATION,
                delay: 0.0,
                usingSpringWithDamping: 1.0,
                initialSpringVelocity: 1.0,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: {
                    keyboardView.transform = CGAffineTransformTranslate(keyboardView.transform, 0.0, keyboardView.frame.size.height)
                    keyboardView.alpha = 0.0
                }, completion: { finished in
                    self.advanceToNextInputMode()
            })
        }
    }
    
    private func checkScreenSize() -> CGFloat {
        var keyboardHeight:CGFloat = 0.0
        if UIScreen.mainScreen().bounds.size.height > UIScreen.mainScreen().bounds.size.width {
            //portrait phone
            if UIScreen.mainScreen().bounds.size.width > 321 {
                //iphone 6 or 6+
                keyboardHeight = self.IPHONE6KEYBOARDHEIGHT
            } else {
                //iphone 4S or 5
                keyboardHeight = self.IPHONE5KEYBOARDHEIGHT
            }
        } else {
            //landscape phone
            if UIScreen.mainScreen().bounds.size.height > 321 {
                //iphone 6 or 6+
                keyboardHeight = self.IPHONE6KEYBOARDHEIGHT
            } else {
                //iphone 4S or 5
                keyboardHeight = self.IPHONE5KEYBOARDHEIGHT
            }
        }
        return keyboardHeight
    }
}
