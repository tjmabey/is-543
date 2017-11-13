//
//  ProfileViewController.swift
//  project1
//
//  Created by Tyler Mabey on 9/27/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit
import MessageUI

class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var phoneNumber: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var aboutField: UILabel!
    @IBOutlet weak var emailField: MyButton!
    @IBOutlet weak var spouseButton: MyButton!
    @IBOutlet weak var textButton: MyButton!
    
    
    // MARK: - Actions
    
    @IBAction func phoneNumber(_ sender: Any) {
        callNumber(phoneNumber: (profile?.phone)!)
    }
    @IBAction func textNumber(_ sender: Any) {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = [(profile?.phone)!]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func emailButton(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            sendEmailErrorAlert()
        }
    }
    
    
    // MARK: - Properties
    var profile: Founder?
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // MARK: - Helpers
    
    func updateUI(with selectedFounder: Founder) {
        profile = selectedFounder
    }
    
    private func updateUI(){
        firstName.text = profile?.fName
        lastName.text = profile?.lName
        companyName.text = profile?.company.uppercased()
        phoneNumber.setTitle("Call", for: .normal)
        textButton.setTitle("Text", for: .normal)
        let img: UIImage = UIImage(named: (profile?.photo)!)!
        self.profilePicture.image = img
        aboutField.text = profile?.profile
        emailField.setTitle(profile?.email, for: .normal)
        var sp = profile?.spouse
        
        if (sp?.isEmpty)! {
            spouseButton.isHidden = true
        }
        else {
            sp = "Spouse: " +  sp!
            spouseButton.setTitle(sp, for: .normal)
        }
        
    }
    
    private func callNumber(phoneNumber: String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber))") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([(profile?.email)!])
        mailComposerVC.setSubject("Lets connect")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendEmailErrorAlert() {
        let sendEmailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendEmailErrorAlert.addAction(dismiss)
        self.present(sendEmailErrorAlert, animated: true, completion: nil)
    }
    
    // MARK: - Segues
    @IBAction func exitModalScene(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func showProfile(_ segue: UIStoryboardSegue) {
        if let current = profile {
            title = current.fName
        }
    }
}


