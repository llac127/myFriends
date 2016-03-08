//
//  DataService.swift
//  myFriends
//
//  Created by Long Lac on 3/7/16.
//  Copyright © 2016 Tinyapps. All rights reserved.
//

import Foundation
import Firebase

class DataService
{
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "https://myfriendz.firebaseio.com")
    
    var REF_BASE: Firebase
        {
        
        return _REF_BASE
    }
}