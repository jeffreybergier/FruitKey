//
// FKKeyboardKeyButton.swift
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

class FKKeyboardKeyButton: UIButton {
    
    private let BORDERWIDTH:CGFloat = 0.0
    private let CORNERRADIUS:CGFloat = 4.0
    private let SHADOWOPACITY:Float = 0.3
    private let SHADOWRADIUS:CGFloat = 0.0
    private let SHADOWOFFSETNORMAL = CGSizeMake(0.0, 1.2)
    private let SHADOWOFFSETPRESSED = CGSizeMake(0.0, 0.2)
    private let ANIMATIONDURATION = 0.05
    private let CHANGECOLORANIMATIONDURATION = 0.2
    private let IPADFONTSIZE: CGFloat = 30.0
    private var fontBold = UIFont(name: "HelveticaNeue-Medium", size: 22)
    private var fontThin = UIFont(name: "HelveticaNeue-Light", size: 22)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //if an ipad, make fonts bigger
        if UIScreen.mainScreen().bounds.size.height > UIScreen.mainScreen().bounds.size.width {
            if UIScreen.mainScreen().bounds.size.width > 767 {
                self.fontBold = UIFont(name: "HelveticaNeue-Medium", size: self.IPADFONTSIZE)
                self.fontThin = UIFont(name: "HelveticaNeue-Light", size: self.IPADFONTSIZE)
            }
        } else {
            if UIScreen.mainScreen().bounds.size.height > 767 {
                self.fontBold = UIFont(name: "HelveticaNeue-Medium", size: self.IPADFONTSIZE)
                self.fontThin = UIFont(name: "HelveticaNeue-Light", size: self.IPADFONTSIZE)
            }
        }
        
        //configure the color and border of the buttons
        self.prepareButtonBorder()
        
        //add targets for touchdown and touchup
        self.addTarget(self, action: "didTouchDownOnKey:", forControlEvents: UIControlEvents.TouchDown)
        self.addTarget(self, action: "didTouchUpOffKey:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addTarget(self, action: "didTouchUpOffKey:", forControlEvents: UIControlEvents.TouchUpOutside)
        
        //register for notifications for the keyboard changing from dark to light
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidChangeToLight:", name: "keyboardShouldBeLight", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidChangeToDark:", name: "keyboardShouldBeDark", object: nil)
    }
    
    private func prepareButtonBorder() {
        self.clipsToBounds = false
        
        self.backgroundColor = FKColorProvider.buttonBackgroundLightColor()
        self.layer.borderColor = FKColorProvider.buttonBorderColor().CGColor
        self.layer.shadowColor = FKColorProvider.buttonShadowColor().CGColor
        self.tintColor = FKColorProvider.buttonLabelLightColor()
        
        self.layer.borderWidth = self.BORDERWIDTH
        self.layer.cornerRadius = self.CORNERRADIUS
        
        self.layer.shadowOffset = self.SHADOWOFFSETNORMAL
        self.layer.shadowOpacity = self.SHADOWOPACITY
        self.layer.shadowRadius = self.SHADOWRADIUS
        
        if UIAccessibilityIsBoldTextEnabled() {
            //bold fonts enabled in system preferences
            self.titleLabel?.font = self.fontBold
        } else {
            //normal fonts enabled in system preferences
            self.titleLabel?.font = self.fontThin
        }
    }
    
    func keyboardDidChangeToLight(notification: NSNotification) {
        UIView.animateWithDuration(self.CHANGECOLORANIMATIONDURATION,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.backgroundColor = FKColorProvider.buttonBackgroundLightColor()
                self.layer.borderColor = FKColorProvider.buttonBorderColor().CGColor
                self.layer.shadowColor = FKColorProvider.buttonShadowColor().CGColor
                self.tintColor = FKColorProvider.buttonLabelLightColor()
            }, completion: { finished in
                //
        })
    }
    
    func keyboardDidChangeToDark(notification: NSNotification) {
        UIView.animateWithDuration(self.CHANGECOLORANIMATIONDURATION,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.backgroundColor = FKColorProvider.buttonBackgroundDarkColor()
                self.layer.borderColor = FKColorProvider.buttonBorderColor().CGColor
                self.layer.shadowColor = FKColorProvider.buttonShadowColor().CGColor
                self.tintColor = FKColorProvider.buttonLabelDarkColor()
            }, completion: { finished in
                //
        })
    }
    
    func didTouchDownOnKey(sender: FKKeyboardKeyButton) {
        UIView.animateWithDuration(self.ANIMATIONDURATION, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            self.layer.shadowOffset = self.SHADOWOFFSETPRESSED
            }, completion: nil)
    }
    
    func didTouchUpOffKey(sender: FKKeyboardKeyButton) {
        UIView.animateWithDuration(self.ANIMATIONDURATION, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            self.layer.shadowOffset = self.SHADOWOFFSETNORMAL
            }, completion: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
