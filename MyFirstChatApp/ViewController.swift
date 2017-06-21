//
//  ViewController.swift
//  MyFirstChatApp
//
//  Created by Bhavin on 26/05/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    
    var messages = [Messages]()
    var messageDictionary = [String: Messages]()

    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(handleNewMessage))
        
        tableView.register(userCell.self, forCellReuseIdentifier: cellId)

       // observeMessages()
        tableView.allowsMultipleSelectionDuringEditing = true
        
        //checkIfTheUserIsLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        checkIfTheUserIsLoggedIn()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let uid = Auth.auth().currentUser?.uid else{
            print("coulnt find user")
            return
        }
        
        let message = self.messages[indexPath.row]
        if let chatPartnerId = message.chatPartnerId(){
            Database.database().reference().child("user-messages").child(uid).child(chatPartnerId).removeValue(completionBlock: { (err, ref) in
                if err != nil{
                    print("error in deletion")
                    return
                }
                
                self.messageDictionary.removeValue(forKey: chatPartnerId)
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            })
        }
       
    }
    
    func observeUserMessages(){
        
        guard let uid = Auth.auth().currentUser?.uid else{
            print("coulnt find user")
            return
        }
        
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            
            let messageId = snapshot.key
            
            let messageReference = Database.database().reference().child("messages").child(messageId)
            messageReference.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: Any]{
                    
                    let message = Messages()
                    message.setValuesForKeys(dictionary)
                    
                    if let partnerId = message.chatPartnerId(){
                        self.messageDictionary[partnerId] = message
                        self.messages = Array(self.messageDictionary.values)
                        self.messages.sort(by: { (m1, m2) -> Bool in
                            return (m1.timestamp?.intValue)! > (m2.timestamp?.intValue)!
                        })
                    }
                    
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }
                
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? userCell
        
        let message = messages[indexPath.row]
        
        
        cell?.message = message
        
        
         
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        
        guard let partnerId = message.chatPartnerId() else{
            return
        }
        
        let ref = Database.database().reference().child("users").child(partnerId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any]{
                let user = User()
                user.id = partnerId
                user.setValuesForKeys(dictionary)
                self.showChatControllerForUser(user: user)
            }
        }, withCancel: nil)
        
        
        //showChatControllerForUser(user: <#T##User#>)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    
    func handleNewMessage(){
        
        let messageController = NewMessageTableViewController()
        messageController.messagesController = self
        let NavigationControllerForNewMessage = UINavigationController(rootViewController: messageController)
        
        present(NavigationControllerForNewMessage, animated: true, completion: nil)
        
    }
    
    
    func showChatControllerForUser(user: User){
        print("123")
        
        let chatController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatController.user = user
        
        navigationController?.pushViewController(chatController, animated: true)
        
        
    }
    
    func setUPNavBarWithUser(loggedInUser: User){
        
        messages.removeAll()
        messageDictionary.removeAll()
        tableView.reloadData()
        
        observeUserMessages()
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        
        titleView.addSubview(nameLabel)
        
        nameLabel.text = loggedInUser.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: titleView.heightAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: titleView.widthAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        
        
        self.navigationItem.titleView = titleView
        
        titleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showChatControllerForUser(user:))))
        
        
    }
    
    func checkIfTheUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
        }
        
        else {
            if let uid = Auth.auth().currentUser?.uid{
                Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
                    print (snapshot)
                    
                    guard let dictionary = snapshot.value as? [String: Any] else{
                        print("Couldnt unwrap the values")
                        return
                    }
            
                    let user = User()
                    user.setValuesForKeys(dictionary)
                    self.setUPNavBarWithUser(loggedInUser: user)
                    
                } , withCancel: nil)
            }
            
        }
    }
    
    
    func handleLogout(){
        
        do {
            try Auth.auth().signOut()
        }catch let error{
            print(error)
        }
        
        let logincontroller = LoginController()
        present(logincontroller, animated: true, completion: nil)
    }

}

