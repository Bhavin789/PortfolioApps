//
//  AakashSirViewController.swift
//  test2
//
//  Created by Bhavin on 14/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class AakashSirViewController: UIViewController {

    @IBOutlet weak var websiteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        websiteButton.alpha = 0
        websiteButton.layer.cornerRadius = 10
        
        UIView.animate(withDuration: 0.8) {
            self.websiteButton.alpha = 1
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showWebsite(_ sender: Any) {
        
        self.performSegue(withIdentifier: "myWebsite", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationSegue = segue.destination as! HallOfFameDetailViewController
        destinationSegue.name = "Aakash Chowdhary"
        destinationSegue.url = "http://crookedcomputing.weebly.com"
    }

}
