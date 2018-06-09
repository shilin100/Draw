//
//  AppDelegate.swift
//  Draw
//
//  Created by 123 on 2018/5/26.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import LeanCloud
import IQKeyboardManager


let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        LeanCloud.initialize(applicationID: "vJofpL6dCY46y6tQJekfbIHi-gzGzoHsz", applicationKey: "LoiHH1yEVVi7Ht4GQkTG3075")
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
//        UserDefaults.standard.removeObject(forKey: "uid")
        setNavigationBarApperance()
        return true
    }
    
    func setNavigationBarApperance()  {
        UINavigationBar.appearance().tintColor = .white //前景色，按钮颜色
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.368627451, green: 0.2509803922, blue: 0.937254902, alpha: 1) //背景色，导航条背景色
        UINavigationBar.appearance().isTranslucent = true // 导航条背景是否透明
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white] // 设置导航条标题颜色，还可以设置其它文字属性，只需要在里面添加对应的属性

    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

