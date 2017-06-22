//
//  Stack.swift
//  test2
//
//  Created by Bhavin on 09/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import Foundation

class Stack {
    
    var contents = [[String]]()
    var lastIndex: Int = -1
    
    func push(_ item: [String]) {
        contents.append(item)
        lastIndex = lastIndex + 1
    }
    
    func pop() -> [String] {
        
        if contents.isEmpty{
            return [""]
        }
        else{
            let index = lastIndex
            let string = contents.remove(at: index)
            lastIndex = lastIndex - 1
            return string
        }
    }
    
    func isEmpty() -> Bool{
        return contents.isEmpty
    }
    
    func getNumberOfElements() -> Int{
        return contents.count
    }
    
}
