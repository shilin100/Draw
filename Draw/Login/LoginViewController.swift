//
//  LoginViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/8.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import LeanCloud
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var psw: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginAction(_ sender: Any) {
        if psw.text!.count > 0, username.text!.count>0 {
            LCUser.logIn(username: username.text!, password: psw.text!) { result in
                switch result {
                case .success(let user):
                    UserDefaults.standard.set(user.objectId, forKey: "uid")
                    self.dismiss(animated: true, completion: nil)
                    break
                case .failure(let error):
                    print(error)
//                    SVProgressHUD.showError(withStatus: error.userInfo)
                }
                
            }

            
            
        }
        
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
