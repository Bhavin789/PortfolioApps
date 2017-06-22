//
//  HallOfFameViewController.swift
//  test2
//
//  Created by Bhavin on 13/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class HallOfFameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var hallOfFameLabel: UILabel!
    var indexPathForRow: Int?
    
    var teamMates = [TeamMate(Name: "Akshay Jain", urlString: "https://www.facebook.com/akshay.jain1995"),
                     TeamMate(Name: "Aniket Kamra", urlString: "https://www.facebook.com/aniket.kamra"),
                     TeamMate(Name: "Aditya Singh", urlString: "https://www.facebook.com/adityasingh03"),
                     TeamMate(Name: "Ashish Walia", urlString: "https://www.facebook.com/ash.walia"),
                     TeamMate(Name: "Rohan Khanna", urlString: "https://www.facebook.com/rohan.khanna95"),
                     TeamMate(Name: "Sagar Pathare", urlString: ""),
                     TeamMate(Name: "Shreshth Jai﻿n", urlString: "https://www.facebook.com/duperbest"),
                     TeamMate(Name: "Uttiyo Silroy", urlString: "https://www.facebook.com/Sect0r7"),
                     TeamMate(Name: "Vivek Chattopadhyay", urlString: ""),
                     TeamMate(Name: "Prachetas Patel", urlString: "https://www.facebook.com/PracheJP?ref=pb"),
                     TeamMate(Name: "Akshay Walvekar", urlString: "https://www.facebook.com/AkshuWalvekar?ref=pb"),
                     TeamMate(Name: "Pulkit Vashishth", urlString: ""),
                     TeamMate(Name: "Tejeshwar Singh", urlString: "https://www.facebook.com/tejeshwar.singh.73"),
                     TeamMate(Name: "Shubham Mandal", urlString: "https://www.facebook.com/shubham.mandal.39"),
                     TeamMate(Name: "Aditya Venkateswaran", urlString: "https://www.facebook.com/aditya.coolboy.5"),
                     TeamMate(Name: "Abhishek Sethi", urlString: "https://www.facebook.com/ab.sethi?ref=pb"),
                     TeamMate(Name: "Sujayendra Krishna Nellore", urlString: "https://www.facebook.com/nskrishna2?ref=pb"),
                     TeamMate(Name: "Swapnil Rastogi", urlString: "https://www.facebook.com/swapras?ref=pb"),
                     TeamMate(Name: "Jayanta Patra", urlString: "https://www.facebook.com/jayantapatra007")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamMates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = teamMates[indexPath.row].Name
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexPathForRow = indexPath.row
        self.performSegue(withIdentifier: "teamMate", sender: self)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        hallOfFameLabel.alpha = 0
        UIView.animate(withDuration: 4              ) {
            self.hallOfFameLabel.alpha = 1
        }

        hallOfFameLabel.layer.masksToBounds = true
        hallOfFameLabel.layer.shadowColor = UIColor.white.cgColor
        hallOfFameLabel.layer.shadowOpacity = 0.5
        hallOfFameLabel.layer.shadowRadius = 20
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationSegue = segue.destination as! HallOfFameDetailViewController
        
        if let name = teamMates[indexPathForRow!].Name, let url = teamMates[indexPathForRow!].urlString{
           destinationSegue.name = name
           destinationSegue.url = url
        }
        
    }
}
