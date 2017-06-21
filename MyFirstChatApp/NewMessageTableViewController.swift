//
//  NewMessageTableViewController.swift
//  MyFirstChatApp
//
//  Created by Bhavin on 29/05/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit
import Firebase

class NewMessageTableViewController: UITableViewController {
    
    let cellId = "Users"
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view loaded")

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        tableView.register(userCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("View Appeared")
        getUsers()
        
    }
    
    
    func getUsers(){
        let ref = Database.database().reference().child("users")
        ref.observe(.childAdded, with: { (snapshot) in
           // print(snapshot)
            
            if let dictionary = snapshot.value as? [String: Any]{
                let user = User()
                user.setValuesForKeys(dictionary)
                user.id = snapshot.key
                self.users.append(user)
                
                DispatchQueue.main.async(execute: { 
                    self.tableView.reloadData()
                })
                
                //print(user.mail!, user.name!)
            }
            
            else{
                print("No user found")
                return
            }
            
        }, withCancel: nil)
    }
    
    
    func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? userCell
        
        let user = users[indexPath.row]
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text = user.mail
        //cell.imageView?.image = UIImage(named:"initialProfileImage")
        
        if let profileImageUrl = user.profileImageUrl{
            
            cell?.profileImage.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
            
/*            //print(profileImageUrl)
            let imageUrl = NSURL(string: profileImageUrl)
            
            let request = URLRequest(url:imageUrl! as URL)
            
            //print(request)
            
            URLSession.shared.dataTask(with: request, completionHandler: { (Data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                DispatchQueue.main.async(execute: {
                   cell?.profileImage.image = UIImage(data: Data!)
                })
                
                
            }).resume()*/
        }
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
        
    }
    
    var messagesController: ViewController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { 
            print("dimissed")
            
            let user = self.users[indexPath.row]
            
            self.messagesController?.showChatControllerForUser(user: user)
        }
    }
}




