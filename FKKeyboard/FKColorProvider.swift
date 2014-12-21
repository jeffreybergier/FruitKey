//
// FKColorProvider.swift
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

class FKColorProvider: NSObject {
    
    class func buttonShadowColor() -> UIColor {
        return UIColor.blackColor()
    }
    
    class func buttonLabelLightColor() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    class func buttonLabelDarkColor() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    class func buttonBorderColor() -> UIColor {
        return UIColor.darkGrayColor()
    }
    
    class func buttonBackgroundLightColor() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    class func buttonBackgroundDarkColor() -> UIColor {
        return UIColor(red: 139.0/255.0, green: 139.0/255.0, blue: 139.0/255.0, alpha: 1.0)
    }
    
    class func keyboardBackgroundLightColor() -> UIColor {
        return UIColor(red: 209.0/255.0, green: 214.0/255.0, blue: 219.0/255.0, alpha: 1.0)
    }
    
    class func keyboardBackgroundDarkColor() -> UIColor {
        return UIColor(red: 89.0/255.0, green: 89.0/255.0, blue: 89.0/255.0, alpha: 1.0)
    }

}
