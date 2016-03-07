//
//  MaterialTextField.swift
//  myFriends
//
//  Created by Long Lac on 3/6/16.
//  Copyright © 2016 Tinyapps. All rights reserved.
//

import UIKit

class MateraiTextField: UITextField
{
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.1).CGColor

        layer.borderWidth = 1.0
        
    }
    
    //For placeholder to move text to the right
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
}
