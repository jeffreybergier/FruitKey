//
// AboutTableViewController.swift
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
import MessageUI

class AboutTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet private weak var appDescriptionTextLabel: UILabel!
    @IBOutlet private weak var companyImageView: UIImageView!
    @IBOutlet private weak var companyTextLabel: UILabel!
    @IBOutlet private weak var companyEmailMeButton: UIButton!
    @IBOutlet private weak var companyReviewThisAppButton: UIButton!
    
    private let applicationID: Double = 936505240
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textSizeDidChange:", name: "UIContentSizeCategoryDidChangeNotification", object: nil)
        self.appDescriptionTextLabel.text = NSLocalizedString("FruitKeyAppDescription", comment: "This is the text that appears in the about screen and it describes why I created the app")
        self.companyTextLabel.text = NSLocalizedString("CompanyMyselfPersonalDescription", comment: "This is the text that appears in the about screen and it describes me and asks users to email me if they like the app")
        self.companyEmailMeButton.setTitle(NSLocalizedString("Email Me", comment: "This button allows the user to email me for support or to say they like the application"), forState: UIControlState.Normal)
        self.companyReviewThisAppButton.setTitle(NSLocalizedString("Review this App", comment: "this button allows the user to review the app in the app store."), forState: UIControlState.Normal)
        self.companyImageView.layer.cornerRadius = self.companyImageView.frame.size.width/2
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var titleString = ""
        
        switch section {
        case 0:
            titleString = NSLocalizedString("FruitKey", comment: "this is the title of the application that appears in the about screen. This probably shouldn't change.")
        case 1:
            titleString = NSLocalizedString("SaturdayApps", comment: "this is the name of my company. It probably shouldn't change.")
        default:
            println("AboutTableViewController: The title for section \(section) is unknown.")
        }
        
        return titleString
    }
    
    @IBAction func didTapEmailMeButton(sender: UIButton) {
        let subject = NSLocalizedString("I love FruitKey", comment: "This is the subject line of support requests. It should say something positive about the app but its mostly gonna be used when people are upset")
        let body = NSLocalizedString("", comment: "this is the body line of support requests, it should be blank, but the possibilies are endless")
        
        if MFMailComposeViewController.canSendMail() {
            let mailer = MFMailComposeViewController()
            mailer.mailComposeDelegate = self
            mailer.setSubject(subject)
            mailer.setToRecipients(["support@saturdayapps.com"])
            mailer.setMessageBody(body, isHTML: false)
            
            self.presentViewController(mailer, animated: true, completion: nil)
        } else {
            let mailStringWrongEncoding = NSString(format: "mailto:support@saturdayapps.com?subject=%@&body=%@", subject, body)
            let mailString = mailStringWrongEncoding.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            if let mailString = mailString {
                let mailToURL = NSURL(string: mailString)
                if let mailToURL = mailToURL {
                    UIApplication.sharedApplication().openURL(mailToURL)
                }
            }
        }
    }
    
    @IBAction func didTapReviewThisAppButton(sender: UIButton) {
        let appStoreString = NSString(format: "itms-apps://itunes.apple.com/app/%f", self.applicationID)
        let appStoreURL = NSURL(string: appStoreString as String)
        if let appStoreURL = appStoreURL {
            UIApplication.sharedApplication().openURL(appStoreURL)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.tableView.reloadData()
        if let presentedViewController = self.presentedViewController {
            presentedViewController.dismissViewControllerAnimated(true, completion: nil)
        }
        if error != nil {
            println("AboutTableViewController: Error while sending email. Error Description: \(error.description)")
        }
    }
    
    func textSizeDidChange(notification: NSNotification) {
        let newFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.appDescriptionTextLabel.font = newFont
        self.companyTextLabel.font = newFont
        self.companyEmailMeButton.titleLabel?.font = newFont
        self.companyReviewThisAppButton.titleLabel?.font = newFont
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
