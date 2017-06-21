//
//  UserCell.swift
//  MyFirstChatApp
//
//  Created by Bhavin on 08/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit
import Firebase

class userCell: UITableViewCell{
    
    var message: Messages?{
        didSet{
            
            detailTextLabel?.text = message?.text
            
            if let seconds = message?.timestamp?.doubleValue{
                let timeStampDate = NSDate(timeIntervalSince1970: seconds)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                
                timeLabel.text = dateFormatter.string(from: timeStampDate as Date)
                setupNameAndProfileImage()
                
            }
            
        }
    }
    
    private func setupNameAndProfileImage(){
        
        if let id = message?.chatPartnerId() {
            let ref = Database.database().reference().child("users").child(id)
            ref.observe(.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: Any]{
                    
                    self.textLabel?.text = dictionary["name"] as? String
                    
                    if let profileimageUrl = dictionary["profilrImageUrl"]{
                        self.profileImage.loadImageUsingCacheWithUrlString(urlString: profileimageUrl as! String)
                        
                    }
                    
                }
                
                print(snapshot)
            }, withCancel: nil)
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 56, y: (textLabel?.frame.origin.y)!, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        
        detailTextLabel?.frame = CGRect(x: 56, y: (detailTextLabel?.frame.origin.y)!, width: (detailTextLabel?.frame.width)!, height: (detailTextLabel?.frame.height)!)
    }
    
    let profileImage: UIImageView = {
        
        let profileimageView = UIImageView()
        profileimageView.image = UIImage(named: "initialProfileImage")
        profileimageView.translatesAutoresizingMaskIntoConstraints = false
        profileimageView.layer.cornerRadius = 20
        profileimageView.layer.masksToBounds = true
        return profileimageView
    }()
    
    let timeLabel: UILabel = {
       let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label .translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImage)
        addSubview(timeLabel)
        
        
        profileImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
