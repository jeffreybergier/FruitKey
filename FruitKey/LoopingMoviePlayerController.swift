//
// InstructionsViewController.swift
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
import MediaPlayer

class LoopingMoviePlayerController: MPMoviePlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.moviePlayer.repeatMode = MPMovieRepeatMode.One
        self.moviePlayer.scalingMode = MPMovieScalingMode.AspectFit
        self.moviePlayer.controlStyle = MPMovieControlStyle.None
        self.moviePlayer.allowsAirPlay = false
        self.moviePlayer.backgroundView.backgroundColor = UIColor.whiteColor()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let statusBarTimer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: "showStatusBarTimer:", userInfo: nil, repeats: false)
    
        self.moviePlayer.play()
        self.moviePlayer.controlStyle = MPMovieControlStyle.None
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showStatusBarTimer(timer: NSTimer?) {
        timer?.invalidate()

        if let navigationController = self.navigationController {
            if let tabBarController = self.tabBarController {
                let movieFrame = CGRectMake(0, navigationController.navigationBar.frame.size.height + UIApplication.sharedApplication().statusBarFrame.size.height, self.view.frame.size.width, self.view.frame.size.height-tabBarController.tabBar.frame.size.height-navigationController.navigationBar.frame.size.height-UIApplication.sharedApplication().statusBarFrame.size.height)
                self.moviePlayer.view.frame = movieFrame
            }
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition(nil, completion: { finished in
            self.showStatusBarTimer(nil)
        })
    }
}

