//
//  BaseNavigation.swift
//  Draw
//
//  Created by 123 on 2018/6/1.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit

class BaseNavigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
            // *修改导航背景色
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.368627451, green: 0.2509803922, blue: 0.937254902, alpha: 1)
            
            // *修改导航栏文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [kCTForegroundColorAttributeName:UIColor.white] as [NSAttributedStringKey : Any]
            
            // *修改导航栏按钮颜色
            self.navigationController?.navigationBar.tintColor = UIColor.white
            
//            *// *修改导航背景图片*  *不包含状态栏：*44*点（*88*像素）*  *包含状态栏：*64*点*(128*像素）
//            self.navigationController?.navigationBar
//                .setBackgroundImage(UIImage(named: "bg"), forBarMetrics: .Default)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
