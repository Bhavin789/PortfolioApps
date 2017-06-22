//
//  HallOfFameDetailViewController.swift
//  test2
//
//  Created by Bhavin on 13/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class HallOfFameDetailViewController: UIViewController {

    
    @IBOutlet weak var detailView: UIWebView!
    @IBOutlet weak var label: UILabel!
    
    var name: String?
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(url)
        label.textColor = UIColor.white
        label.text = name
        
        guard let urlFetched = self.url else{
            return
        }
        
        let urlConverted = URL(string: urlFetched)
        
        let req = URLRequest(url: urlConverted!)
        detailView.loadRequest(req)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
