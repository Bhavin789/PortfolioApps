//
//  LoginController.swift
//  MyFirstChatApp
//
//  Created by Bhavin on 26/05/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let credentialsInputView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
        
    }()

    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 58/255, green: 128/255, blue: 188/255, alpha: 1)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.restorationIdentifier="loginbutton"
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    
    let nameTextField: UITextField = {
        let txtField = UITextField()
        
        txtField.placeholder = "Name"
        txtField.translatesAutoresizingMaskIntoConstraints = false
        
        return txtField
    }()
    
    let nameSeparator: UIView = {
       
        let nameSeparatorView = UIView()
        nameSeparatorView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        nameSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameSeparatorView
        
        
    }()
    
    
    let mailTextField: UITextField = {
        let mailField = UITextField()
        
        mailField.placeholder = "Email"
        mailField.translatesAutoresizingMaskIntoConstraints = false
        
        return mailField
    }()
    
    let mailSeparator: UIView = {
        
        let mailSeparatorView = UIView()
        mailSeparatorView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        mailSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return mailSeparatorView
        
        
    }()
    
    let passwordTextField: UITextField = {
        let passwordField = UITextField()
        
        passwordField.placeholder = "Password"
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordField
    }()
    
    
    lazy var  profileImageView: UIImageView = {
       
        let profileImage = UIImageView()
        
        profileImage.image = UIImage(named: "initialProfileImage")
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.contentMode = .scaleAspectFill
        
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfileImage)))
        
            profileImage.isUserInteractionEnabled = true
            
        return profileImage
        
    }()
    
    let LoginregisterSegment: UISegmentedControl = {
        
        let control = UISegmentedControl(items: ["Login", "Register"])
        control.tintColor = UIColor.white
        control.selectedSegmentIndex = 1
        control.addTarget(self, action: #selector(LoginRegisterSegmentChanged), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

       view.backgroundColor = UIColor(red: 58/255, green: 119/255, blue: 188/255, alpha: 1)
        
        view.addSubview(credentialsInputView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(LoginregisterSegment)
        setupCredentialsView()
        setupLoginRegisterButton()
        setupProfileImage()
        setupLoginRegisterSegment()
        
    }
    
    func handleProfileImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //If user has picked an image, put it in the imageView and dismiss the image picker.
        if let newImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageView.image = newImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func LoginRegisterSegmentChanged(){
        let title = LoginregisterSegment.titleForSegment(at: LoginregisterSegment.selectedSegmentIndex)
        
        loginRegisterButton.setTitle(title, for: .normal)
        
        if LoginregisterSegment.selectedSegmentIndex == 0{
            credentialsViewHeightAnchor?.constant = 100
            nameHeightAnchor?.isActive = false
            nameHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: credentialsInputView.heightAnchor, multiplier: 0)
            nameTextField.layer.masksToBounds = true
            nameHeightAnchor?.isActive = true
            
            mailHeightAnchor?.isActive = false
            mailHeightAnchor = mailTextField.heightAnchor.constraint(equalTo: credentialsInputView.heightAnchor, multiplier: 1/2)
            
            mailHeightAnchor?.isActive = true
            
            passwordHeightAnchor?.isActive = false
            passwordHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: credentialsInputView.heightAnchor, multiplier: 1/2)
            //passwordTextField.layer.masksToBounds = true
            passwordHeightAnchor?.isActive = true
        }
        else{
            credentialsViewHeightAnchor?.constant = 150
            nameHeightAnchor?.isActive = false
            nameHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: credentialsInputView.heightAnchor, multiplier: 1/3)
            nameHeightAnchor?.isActive = true
            
            mailHeightAnchor?.isActive = false
            mailHeightAnchor = mailTextField.heightAnchor.constraint(equalTo: credentialsInputView.heightAnchor, multiplier: 1/3)
            
            mailHeightAnchor?.isActive = true
            
            passwordHeightAnchor?.isActive = false
            passwordHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: credentialsInputView.heightAnchor, multiplier: 1/3)
            //passwordTextField.layer.masksToBounds = true
            passwordHeightAnchor?.isActive = true

        }
    }
    
    
    func setupLoginRegisterSegment(){
        
        LoginregisterSegment.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoginregisterSegment.bottomAnchor.constraint(equalTo: credentialsInputView.topAnchor, constant: -12).isActive = true
        LoginregisterSegment.widthAnchor.constraint(equalTo: credentialsInputView.widthAnchor).isActive = true
        LoginregisterSegment.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    var credentialsViewHeightAnchor: NSLayoutConstraint?
    var nameHeightAnchor: NSLayoutConstraint?
    var mailHeightAnchor: NSLayoutConstraint?
    var passwordHeightAnchor: NSLayoutConstraint?
    
    func setupCredentialsView(){
        credentialsInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        credentialsInputView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        credentialsInputView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        credentialsViewHeightAnchor = credentialsInputView.heightAnchor.constraint(equalToConstant: 150)
        
        credentialsViewHeightAnchor?.isActive = true
        
        credentialsInputView.addSubview(nameTextField)
        credentialsInputView.addSubview(nameSeparator)
        credentialsInputView.addSubview(mailSeparator)
        credentialsInputView.addSubview(mailTextField)
        credentialsInputView.addSubview(passwordTextField)
        
        
        
        // Mark: constraints for nameTextField
        
        nameTextField.leftAnchor.constraint(equalTo: credentialsInputView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: credentialsInputView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: credentialsInputView.widthAnchor).isActive = true
        nameHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: credentialsInputView.heightAnchor, multiplier: 1/3)
        nameHeightAnchor?.isActive = true
        
        // Mark: constraints for nameSeparatorView
        
        nameSeparator.widthAnchor.constraint(equalTo: credentialsInputView.widthAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        nameSeparator.leftAnchor.constraint(equalTo: credentialsInputView.leftAnchor).isActive = true
        
        // Mark: constraints for mailTextView
        
        mailTextField.leftAnchor.constraint(equalTo: credentialsInputView.leftAnchor, constant: 12).isActive = true
        mailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        mailTextField.widthAnchor.constraint(equalTo: credentialsInputView.widthAnchor).isActive = true
        mailHeightAnchor = mailTextField.heightAnchor.constraint(equalTo: credentialsInputView.heightAnchor, multiplier: 1/3)
        mailHeightAnchor?.isActive = true
        
        // Mark: constraints for mailSeparatorView
        
        mailSeparator.widthAnchor.constraint(equalTo: credentialsInputView.widthAnchor).isActive = true
        mailSeparator.topAnchor.constraint(equalTo: mailTextField.bottomAnchor).isActive = true
        mailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        mailSeparator.leftAnchor.constraint(equalTo: credentialsInputView.leftAnchor).isActive = true
        
        // Mark: constraints for passwordTextView
        
        passwordTextField.leftAnchor.constraint(equalTo: credentialsInputView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: credentialsInputView.widthAnchor).isActive = true
        passwordHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: credentialsInputView.heightAnchor, multiplier: 1/3)
        passwordHeightAnchor?.isActive = true
        
    }
    
    func setupLoginRegisterButton(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: credentialsInputView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: credentialsInputView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupProfileImage(){
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: LoginregisterSegment.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    
    func handleLoginRegister(){
        
        if LoginregisterSegment.selectedSegmentIndex == 0{
            handleLogin()
        }
        
        else{
            handleRegister()
        }
    }
    
    func handleLogin(){
        
        guard let mail = mailTextField.text, let password = passwordTextField.text
            else{
                print("Error while unwrappin the text Fields!!")
                return
        }
        
        
        Auth.auth().signIn(withEmail: mail, password: password) { (User, err) in
            if err != nil{
                print(err!)
                return
            }
            
            //succesfully logged in
            print("Logged in")
            
            self.dismiss(animated: true, completion: nil)
            
        }
    }

    func handleRegister(){
        
        guard let mail = mailTextField.text, let password = passwordTextField.text, let name = nameTextField.text
            else{
                print("Error while unwrappin the text Fields!!")
                return
        }
        
        Auth.auth().createUser(withEmail: mail, password: password) { (User, error) in
            
            if error != nil{
                print(error!)
                
            }
            
            guard let userId = User?.uid else{
                print ("No user id found")
                return
            }
            
            // User successfully authenticated
            
            let imageName = NSUUID().uuidString
            let storageReference = Storage.storage().reference().child("\(imageName).jpg")
            
            if let imageData = UIImageJPEGRepresentation(self.profileImageView.image!, 0.1){
            
            //if let imageData = UIImagePNGRepresentation(self.profileImageView.image!){
                storageReference.putData(imageData, metadata: nil, completion: { (metadata, err) in
                    
                    if err != nil{
                        print(err!)
                        return
                    }
                    
                    
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                        
                        let Values = ["name": name, "mail": mail, "profileImageUrl": profileImageUrl]
                        
                        self.addUserToThedatabase(userId: userId, values: Values)
                    }
                   
                })
            }
            
            
        }
        print("hi there")
    }
    
    private func addUserToThedatabase(userId: String, values: [String: Any]){
        
        let ref = Database.database().reference(fromURL: "https://myfirstchatapp-4ba5a.firebaseio.com/")
        
        let userReference = ref.child("users").child(userId)
       
        userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil{
                print(err!)
                return
            }
            
            print("Success, added the value to the database")
            self.dismiss(animated: true, completion: nil)
            
        })
        
    }

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
