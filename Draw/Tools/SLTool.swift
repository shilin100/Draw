//
//  SLTool.swift
//  Draw
//
//  Created by 123 on 2018/6/6.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit

class SLTool: NSObject {

    
    
}


extension UIView{
    func addConnerAndShadow() {
        self.layer.cornerRadius = 5
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 1, height: 3)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
        
    }
}
