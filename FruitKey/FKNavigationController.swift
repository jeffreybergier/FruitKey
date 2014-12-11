//
//  FKNavigationController.swift
//  FruitKey
//
//  Created by Jeffrey Bergier on 11/1/14.
//  Copyright (c) 2014 Saturday Apps. All rights reserved.
//

import UIKit

class FKNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.sharedApplication().statusBarHidden = false
    }

}
