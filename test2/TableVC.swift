//
//  TableVC.swift
//  test2
//
//  Created by Bhavin on 10/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class TableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!

    struct Video{
        var discription: String!
        var youtubeURL: String!
    }
    
    var videos = [Video(discription: "Bypass Jio 4G 1GB Daily HighSpeed Limit | CCI 2017", youtubeURL: "https://www.youtube.com/embed/m194e6_v_ZU"), Video(discription: "How To Recover Permanently Deleted Files? ", youtubeURL: "https://www.youtube.com/embed/Xd1ID5fYWy4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.isScrollEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Custom
        
        print(indexPath.row)
        cell.lab.textColor = UIColor.white
        
        cell.lab.text = videos[indexPath.row].discription
        getVideo(Str: videos[indexPath.row].youtubeURL, myWebView: cell.videoArea)
        
        
        return cell
    }
    
    func getVideo(Str: String, myWebView: UIWebView){

        
        let url = URL(string: Str)
        
        let req = URLRequest(url: url!)
        myWebView.loadRequest(req)
        
      
    }

}
