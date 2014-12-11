//
//  FKTabBarController.swift
//  FruitKey
//
//  Created by Jeffrey Bergier on 11/1/14.
//  Copyright (c) 2014 Saturday Apps. All rights reserved.
//

import UIKit

class FKTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "goToNextPage:")
        rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "goToNextPage:")
        leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(rightSwipeGestureRecognizer)
        self.view.addGestureRecognizer(leftSwipeGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToNextPage(sender: UISwipeGestureRecognizer) {
        var selectedSegmentIndex = 0
        var numberOfSegments = 0
        if let viewControllers = self.viewControllers {
            numberOfSegments = viewControllers.count
            for i in 0..<viewControllers.count {
                if let selectedViewController = self.selectedViewController {
                    if selectedViewController == viewControllers[i] as UIViewController {
                        selectedSegmentIndex = i
                    }
                }
            }
        }
        if sender.direction == UISwipeGestureRecognizerDirection.Left {
            if selectedSegmentIndex + 1 < numberOfSegments {
                self.selectedIndex = selectedSegmentIndex + 1
            } else {
                self.selectedIndex = 0
            }
        } else {
            if selectedSegmentIndex - 1 >= 0 {
                self.selectedIndex = selectedSegmentIndex - 1
            } else {
                self.selectedIndex = numberOfSegments - 1
            }
        }
    }
}
