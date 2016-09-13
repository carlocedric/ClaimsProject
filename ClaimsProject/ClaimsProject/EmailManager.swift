//
//  EmailManager.swift
//  ClaimsProject
//
//  Created by Lijauco, Carlo Cedric on 13/09/2016.
//  Copyright © 2016 arvato. All rights reserved.
//

import UIKit
import MessageUI

class EmailManager: NSObject, MFMailComposeViewControllerDelegate {

    static let sharedInstance = EmailManager()

    var recipients:[String]?
    var subject:String?
    var messageBody:String? = ""

    private var viewController:UIViewController?

    func sendEmail(recipients toRecipients:[String],subject:String,messageBody:String,inViewController:UIViewController) {

        self.recipients = toRecipients
        self.subject = subject
        self.messageBody = messageBody
        self.viewController = inViewController

        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            inViewController.presentViewController(mailComposeViewController, animated: true, completion: nil)

        } else {
            self.showSendMailErrorAlert()
        }
    }

    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self

        if let recipientList = recipients{
            mailComposerVC.setToRecipients(recipientList)
        }

        if let subjectString = subject{
            mailComposerVC.setSubject(subjectString)
        }

        if let message = messageBody{
            mailComposerVC.setMessageBody(message, isHTML: false)
        }

        return mailComposerVC
    }

    func showSendMailErrorAlert() {

        let sendMailErrorAlert = UIAlertController(title: "Error", message: "The email could not be sent at this time.", preferredStyle: .Alert)

        if let vc = viewController{
            vc.presentViewController(sendMailErrorAlert, animated: true, completion: nil)
        }
    }

    // MARK: MFMailComposeViewControllerDelegate

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
}