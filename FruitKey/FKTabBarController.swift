//
// FKTabBarController.swift
// FruitKey
//
// Created by Jeffrey Bergier on 11/1/14.
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
                    if selectedViewController == viewControllers[i] as! UIViewController {
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
