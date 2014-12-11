//
//  FKColorProvider.swift
//  FruitKey
//
//  Created by Jeffrey Bergier on 10/29/14.
//  Copyright (c) 2014 Saturday Apps. All rights reserved.
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
