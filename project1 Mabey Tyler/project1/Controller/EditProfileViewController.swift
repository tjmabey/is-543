//
//  EditProfileViewController.swift
//  project1
//
//  Created by Tyler Mabey on 10/2/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

class EditProfileViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Constants
    let profile = FounderList.sharedInstance.founderSet[0]
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var busProfileField: UITextView!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var spouseField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
   
    
    // MARK: - Properties
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        updateUI()
    }
    
    // MARK: - Helpers
    
    func updateUI() {
        nameField.text = profile.fullName
        phoneField.text = profile.phone
        busProfileField.text = profile.profile
        companyField.text = profile.company
        
        if let spouse = profile.spouse {
            spouseField.text = spouse
        } 
        
        emailField.text = profile.email
        passwordField.isSecureTextEntry = true
        passwordField.text = "password"
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
    }
    


    
    // MARK: - Actions
    
    @IBAction func choosePic(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - Constants
    
     let picker = UIImagePickerController()
    
    // MARK: - Delegates
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
