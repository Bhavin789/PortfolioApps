//
//  TheTeamViewController.swift
//  test2
//
//  Created by Bhavin on 13/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class TheTeamViewController: UIViewController {
    
    

    @IBOutlet weak var hallOfFameButton: UIButton!
    @IBOutlet weak var ceoButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var ceoButton2: UIButton!
    var ceoButtonStat = false
    var hallOfFameButtonStat = false
    var videoButtonStat = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hallOfFameButton.layer.cornerRadius = 10
        hallOfFameButton.alpha = 0
        UIView.animate(withDuration: 0.8) {
            self.hallOfFameButton.alpha = 1
        }
        ceoButton2.addTarget(self, action: #selector(viewCeoDetail(_:)), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewHallOfFame(_ sender: Any) {
        self.performSegue(withIdentifier: "hallOfFame", sender: self)
        
    }
    
    @IBAction func viewCeoDetail(_ sender: Any) {
        
        ceoButtonStat = true
        self.performSegue(withIdentifier: "aakashSegue", sender: self)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if ceoButtonStat{
            let destinationSegue = segue.destination as! AakashSirViewController
            
        }
        
        else {
            let
        }
        
    }*/

   
    
}
