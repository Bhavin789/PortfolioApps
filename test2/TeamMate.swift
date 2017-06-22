//
//  File.swift
//  test2
//
//  Created by Bhavin on 13/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import Foundation

class TeamMate {
    var Name: String?
    var urlString: String?
    
    init(Name: String, urlString: String){
        self.urlString = urlString
        self.Name = Name
    }
    
    func getName() -> String?{
        return self.Name
    }
    
    func getUrlString() -> String?{
        return self.urlString
    }
}


