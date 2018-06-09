//
//  RegisterViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/8.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import LeanCloud
import SVProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var psw: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var verifyCode: UITextField!
    @IBOutlet weak var phone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func registerAction(_ sender: Any) {
        
        if username.text!.count > 0 , psw.text!.count > 0 , phone.text!.count > 0{
            let randomUser = LCUser()
            
            randomUser.username = LCString(username.text!)
            randomUser.password = LCString(psw.text!)
            randomUser.mobilePhoneNumber = LCString(phone.text!)

            randomUser.signUp { (result) in
                switch result {
                case .success:
                    SVProgressHUD.showSuccess(withStatus: "注册成功")
                    self.navigationController?.popViewController(animated: true)
                    break
                case .failure(let error):
                    print(error)
                    SVProgressHUD.showError(withStatus: error.reason)
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
