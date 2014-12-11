//
//  InstructionsViewController.swift
//  FruitKey
//
//  Created by Jeffrey Bergier on 10/29/14.
//  Copyright (c) 2014 Saturday Apps. All rights reserved.
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

