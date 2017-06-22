//
//  ViewController.swift
//  test2
//
//  Created by Bhavin on 05/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sideContents = [String]()
    var previousTableViewstate = [String]()
    var sideMenuStack = Stack()
    
    
    var tableRowTitle: String?
    var rowTitle: String?
    var arrayOfSideContents = [Any]()
    var segueName: String?
    var urlForWebView: String?
    var initialStateOfSideView: Bool?
    var movedFurther: Bool?
    var sideViewDisplayed: Bool?
    
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var mailButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    var guestUrl = "http://crookedcomputing.weebly.com/contributions.html"
    var copywriteUrl = "http://crookedcomputing.weebly.com/copyright-softwares--crooked-computing-inc.html"
    var androidUrl = "http://crookedcomputing.weebly.com/android.html"
    var multimediaUrl = "http://crookedcomputing.weebly.com/multimedia.html"
    var systemUrl = "http://crookedcomputing.weebly.com/system.html"
    var utilitiesUrl = "http://crookedcomputing.weebly.com/utilities.html"
    var gamesUrl = "http://crookedcomputing.weebly.com/games.html"
    var developersUrl = "http://crookedcomputing.weebly.com/developers.html"
    var androidPrivacyUrl = "http://crookedcomputing.weebly.com/androids-piracy-apps.html"
    var folderLockUrl = "http://crookedcomputing.weebly.com/make-your-own-folder-lock.html"
    var imageEditingUrl = "http://crookedcomputing.weebly.com/image-editing.html"
    var splatArtUrl = "http://crookedcomputing.weebly.com/splat-art.html"
    var processUrl = "http://crookedcomputing.weebly.com/processor.html"
    var windowSurfaceUrl = "http://crookedcomputing.weebly.com/windows-surface.html"
    var windowsCUrl = "http://crookedcomputing.weebly.com/windows-8-consumer-preview"
    var privacyUrl = "http://crookedcomputing.weebly.com/privacy-policy.html"
    var cookiesUrl = "http://crookedcomputing.weebly.com/cookies-policy.html"
    var disclaimerUrl = "http://crookedcomputing.weebly.com/disclaimer.html"
    var termsOfServiceUrl = "http://crookedcomputing.weebly.com/terms-of-service.html"
    var workWithUsUrl = "http://crookedcomputing.weebly.com/work-with-us.html"
    var youtubeUrl = "https://www.youtube.com/channel/UCoRyhR3S8RC6AtUSdUQdwHA"
    var twitterUrl = "https://twitter.com/CrookedCompInc"
    var instagramUrl = "https://www.instagram.com/crookedcomputinginc/"
    var mailUrl = "mailto:crookedcomputinginc@outlook.com"
    var linkedinUrl = "https://www.linkedin.com/company-beta/13297829/"
    var facebookUrl = "https://www.facebook.com/CrookedComputingInc/"
    

    @IBOutlet weak var baritem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var helpUsImproveButton: UIButton!
    @IBOutlet weak var SideViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sideTableView: UITableView!
    @IBOutlet weak var mainViewLeadingSpace: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "crooked"))
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        
        initialStateOfSideView = true
        movedFurther = false
        sideViewDisplayed = false
        
        sideContents = ["Contents","The Team","Work With Us","Privacy Policy","Cookies Policy","Disclaimer","Terms Of Service"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func youtubeClicked(_ sender: Any) {
        setupUrl(youtubeUrl)
        self.performSegue(withIdentifier: "multiSegue", sender: self)
    }
    @IBAction func facebookClicked(_ sender: Any) {
        setupUrl(facebookUrl)
        self.performSegue(withIdentifier: "multiSegue", sender: self)
    }
    @IBAction func linkedinClicked(_ sender: Any) {
        setupUrl(linkedinUrl)
        self.performSegue(withIdentifier: "multiSegue", sender: self)
    }
    @IBAction func twitterClicked(_ sender: Any) {
        setupUrl(twitterUrl)
        self.performSegue(withIdentifier: "multiSegue", sender: self)
    }
    @IBAction func mailClicked(_ sender: Any) {
        setupUrl(mailUrl)
        self.performSegue(withIdentifier: "multiSegue", sender: self)
    }
    @IBAction func instagramClicked(_ sender: Any) {
        setupUrl(instagramUrl)
        self.performSegue(withIdentifier: "multiSegue", sender: self)
    }
    @IBAction func handleSide(_ sender: Any) {
        
        print(initialStateOfSideView!)
        print(sideContents)
        print(sideViewDisplayed!)
        if sideViewDisplayed == true{
            
            if initialStateOfSideView!{
                
                SideViewLeadingConstraint.constant = -216
                
                sideView.layer.shadowOpacity = 0
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
                sideViewDisplayed = !sideViewDisplayed!
            }
                
            else{
                
                let previousContents = sideMenuStack.pop()
                
                print(previousContents)
                sideContents = previousContents
                UIView.transition(with: tableView,
                                  duration: 0.35,
                                  options: .transitionCrossDissolve,
                                  animations: { self.tableView.reloadData() })
                if sideMenuStack.getNumberOfElements() == 0{
                    initialStateOfSideView = true
                }
                
            }
        }else{
            
            SideViewLeadingConstraint.constant = 0
            
            sideView.layer.masksToBounds = false
            sideView.layer.shadowColor = UIColor.black.cgColor
            sideView.layer.shadowOpacity = 0.5
            sideView.layer.shadowRadius = 10
            
            
            UIView.animate(withDuration: 0.3, animations: { 
                self.view.layoutIfNeeded()
            })
            sideViewDisplayed = !sideViewDisplayed!
            print(initialStateOfSideView!)
            print(sideViewDisplayed!)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideCell", for: indexPath)
        
        cell.textLabel?.text = sideContents[indexPath.row]
        cell.textLabel?.textColor = UIColor(red: 0/255, green: 0/225, blue: 0/255, alpha: 0.5)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideContents.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(initialStateOfSideView!)
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
        
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        
        guard let tableRowTitle = currentCell.textLabel?.text else{
            return
        }
        
            switch tableRowTitle {
            case "Videos":
                print("hi")
                rowTitle = tableRowTitle
                performSegue(withIdentifier: "hello", sender: self)
                
            case "The Team":
                rowTitle = tableRowTitle
                self.performSegue(withIdentifier: "team", sender: self)
                
            case "Guest Contributors":
                setupUrl(guestUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
            case "Work With Us":
                setupUrl(workWithUsUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
            case "Privacy Policy":
                setupUrl(privacyUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
            case "Cookies Policy":
                setupUrl(cookiesUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
            case "Disclaimer":
                setupUrl(disclaimerUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
            case "Terms Of Service":
                setupUrl(termsOfServiceUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
                
            case "Games":
                setupUrl(gamesUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
            case "Multimedia":
                setupUrl(multimediaUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
            case "System":
                setupUrl(systemUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
            case "Utilities":
                setupUrl(utilitiesUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
            case "Developers":
                setupUrl(developersUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
            case "Work With US":
                setupUrl(workWithUsUrl)
                self.performSegue(withIdentifier: "multiSegue", sender: self)
                
            default:
                previousTableViewstate = sideContents
                sideMenuStack.push(previousTableViewstate)
                initialStateOfSideView = false
                
                reloadSideViewContents(title: tableRowTitle)
                
                
                UIView.transition(with: tableView,
                                  duration: 0.35,
                                  options: .transitionCrossDissolve,
                                  animations: { tableView.reloadData() })
        
        
        }
        
    }
    
    func setupUrl(_ url: String){        
        urlForWebView = url
    }
    
    func reloadSideViewContents(title: String){
        
        switch title {
        case "Contents":
            
            sideContents = ["Videos","Guest Contributors","Mobile","Multimedia","System","Utilities","Games","Gaming","Developers","Write-Ups","Hardware"]
            
        case "Mobile":
            sideContents = ["Android","iOS"]
        
        case "Hardware":
            sideContents = ["Processor","Windows Surface", "Windows 8 Consumer Preview"]
        
        case "Write-Ups":
            sideContents = ["Android Privacy Apps", "Do It Yourself"]
        
        case "Do It Yourself":
            sideContents = ["Art and Photography", "Make Your Own Folder Lock"]
        
        case "Art and Photography":
            sideContents = ["Image Editing", "Splat Art!"]
            
        case "Gaming":
            sideContents = ["Reviews"]
            
        case "Reviews":
            sideContents = ["2011","2012"]
            
        case "2011":
            sideContents = ["BatmanArkhamCity","Dead Island","Elder Scrolls: Skyrim"]
            
        case "2012":
            sideContents = ["The Darkness II", "Asura's Wrath"]
            
        default:
            print("hi")
        }
        
        }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            print("table row title \(rowTitle)")
            if rowTitle == "The Team"{
                
            }
            else if rowTitle == "Videos"{
            }
            else  {
                let destinationSegue = segue.destination as! HallOfFameDetailViewController
                destinationSegue.url = urlForWebView
        }   
    }
}
    
