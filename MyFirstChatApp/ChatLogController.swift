//
//  ChatLogController.swift
//  MyFirstChatApp
//
//  Created by Bhavin on 05/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var messages = [Messages]()
    var cellId = "cellId"
    
    var user: User? {
        didSet{
            navigationItem.title = user?.name
            observeMessages()
        }
        
        
    }
    
    func observeMessages(){
        
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        let messageRef = Database.database().reference().child("user-messages").child(uid)
        messageRef.observe(.childAdded, with: { (snapshot) in
            
            let messageId = snapshot.key
            let ref = Database.database().reference().child("messages").child(messageId)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else {
                    return
                }
                
                let message = Messages()
                message.setValuesForKeys(dictionary)
                
                if message.chatPartnerId() == self.user?.id{
                
                    self.messages.append(message)
                    
                    DispatchQueue.main.async(execute: {
                        self.collectionView?.reloadData()
                        let lastIndexPath = NSIndexPath(item: self.messages.count - 1, section: 0)
                        self.collectionView?.scrollToItem(at: lastIndexPath as IndexPath, at: .bottom, animated: true)
                    })
                    
                }
                
                
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    
    lazy var messageView: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Message"
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 58, right: 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupInputView()
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell
        let message = messages[indexPath.row]
        cell.textView.text = message.text
        
        if let userProfileImage = self.user?.profileImageUrl{
            cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: userProfileImage)
        }
        
        if let messageImageUrl = message.imageUrl{
            cell.messageImageView.loadImageUsingCacheWithUrlString(urlString: messageImageUrl)
            cell.messageImageView.isHidden = false
            cell.bubbleView.backgroundColor = UIColor.clear
        }else{
            cell.messageImageView.isHidden = true
        }
        
        if message.fromId == Auth.auth().currentUser?.uid{
            
             // MARK: outgoing blue
            
            cell.bubbleView.backgroundColor = UIColor(red: 0/155, green: 137/255, blue: 249/255, alpha: 1)
            cell.textView.textColor = UIColor.white
            cell.bubbleRightAnchor?.isActive = true
            cell.bubbleLeftAnchor?.isActive = false
            cell.profileImageView.isHidden = true
        }else{
            
            // MARK: incoming gray
            
            cell.bubbleView.backgroundColor = UIColor(red: 240/155, green: 240/255, blue: 240/255, alpha: 0.5)
            cell.profileImageView.isHidden = false
            cell.textView.textColor = UIColor.black
            cell.bubbleRightAnchor?.isActive = false
            cell.bubbleLeftAnchor?.isActive = true
        }
        
        if let text = message.text{
            cell.bubbleWidthAnchor?.constant = getEstimatedFrameForText(text: text).width + 32
        } else if message.imageUrl != nil{
            print(message.imageUrl!)
            cell.bubbleWidthAnchor?.constant = 200
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        
        let message = messages[indexPath.item]
        if let text = message.text{
            height = getEstimatedFrameForText(text: text).height + 20
        }
      /*  else if let imageWidth = message.imageWidth?.floatValue, let imageHeight = message.imageHeight?.floatValue{
            height = CGFloat(imageHeight/(imageWidth*200))
            
            print(height)
        }*/
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    private func getEstimatedFrameForText(text: String) -> CGRect{
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout() 
    }
    
    func setupInputView(){
        
        let containerView = UIView()
        
        containerView.backgroundColor = UIColor.white
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let uploadImageView = UIImageView()
        uploadImageView.isUserInteractionEnabled = true
        uploadImageView.translatesAutoresizingMaskIntoConstraints = false
        uploadImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        uploadImageView.image = UIImage(named: "initialProfileImage")
        
        view.addSubview(containerView)
        containerView.addSubview(uploadImageView)
    
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(sendButton)
        
        // MARK: Constraints for the send button
        
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        
        containerView.addSubview(messageView)
        
        // MARK: Constraints for message view
        
        messageView.leftAnchor.constraint(equalTo: uploadImageView.rightAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        messageView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        messageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        containerView.addSubview(separatorView)
        
        separatorView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        
        //MARK: constraints for uploadImageView
        
        uploadImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        uploadImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        uploadImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        uploadImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true

    }
    
    func handleTap(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker{
            uploadToFireBase(selectedImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func uploadToFireBase(_ selectedImage: UIImage?){
        let imageName = NSUUID().uuidString
        let storageReference = Storage.storage().reference().child("messages_Images").child(imageName)
        if let data = UIImageJPEGRepresentation(selectedImage!, 0.2){
            storageReference.putData(data, metadata: nil, completion: { (metaData, err) in
                if err != nil{
                    print(err!)
                    return
                }
                
                if let imageUrl = metaData?.downloadURL()?.absoluteString{
                    self.setUpMessageWithImageUrl(imageUrl, image: selectedImage!)
                }
                
            })
        }
    }
    
    private func setUpMessageWithImageUrl(_ imageUrl: String, image: UIImage){
        
        let ref = Database.database().reference().child("messages")
        let childref = ref.childByAutoId()
        let fromId = Auth.auth().currentUser?.uid
        let toId = user?.id!
        let timestamp = NSDate().timeIntervalSince1970
        let values = ["toId": toId!, "fromId": fromId!, "timestamp": timestamp, "imageUrl": imageUrl, "imageWidth": image.size.width, "imageHeight": image.size.height] as [String : Any]
        childref.updateChildValues(values) { (err, ref) in
            if err != nil{
                print(err!)
                return
            }
            
            self.messageView.text = nil
            
            let userMessagesRef = Database.database().reference().child("user-messages").child(fromId!)
            
            let messageId = childref.key
            userMessagesRef.updateChildValues([messageId: 1])
            
            let recipientUserMessagesRef = Database.database().reference().child("user-messages").child(toId!)
            recipientUserMessagesRef.updateChildValues([messageId: 1])
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
        
    func handleSend(){
        let ref = Database.database().reference().child("messages")
        let childref = ref.childByAutoId()
        let fromId = Auth.auth().currentUser?.uid
        let toId = user?.id!
        let timestamp = NSDate().timeIntervalSince1970
        let values = ["text": messageView.text!, "toId": toId!, "fromId": fromId!, "timestamp": timestamp] as [String : Any]
        childref.updateChildValues(values) { (err, ref) in
            if err != nil{
                print(err!)
                return
            }
            
            self.messageView.text = nil
            
            let userMessagesRef = Database.database().reference().child("user-messages").child(fromId!)
            
            let messageId = childref.key
            userMessagesRef.updateChildValues([messageId: 1])
            
            let recipientUserMessagesRef = Database.database().reference().child("user-messages").child(toId!)
            recipientUserMessagesRef.updateChildValues([messageId: 1])
        }
        
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
        
        }
}
