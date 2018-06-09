//
//  SLTool.swift
//  Draw
//
//  Created by 123 on 2018/6/6.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit

class SLTool: NSObject {
    class func loginVerfy() {
        if UserDefaults.standard.object(forKey: "uid") == nil {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewNavigationController")
            UIViewController.currentViewController()?.present(vc, animated: true, completion: nil)
            
        }
    }

    
    
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

extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}

