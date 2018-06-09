//
//  ChangePSWViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/8.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import LeanCloud
import SVProgressHUD

class ChangePSWViewController: UIViewController {

    @IBOutlet weak var newPswAgain: UITextField!
    @IBOutlet weak var newPsw: UITextField!
    @IBOutlet weak var oldPsw: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func changePswAction(_ sender: Any) {
        if oldPsw.text!.count > 0 , newPsw.text!.count > 0 , newPswAgain.text!.count > 0, newPsw.text! == newPswAgain.text!{
            if LCUser.current == nil {
                SVProgressHUD.showSuccess(withStatus: "修改成功")
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            let currentUser = LCUser.current!
            
            currentUser.updatePassword(oldPassword: oldPsw.text!, newPassword: newPsw.text!) { (result) in
                switch result {
                case .success:
                    SVProgressHUD.showSuccess(withStatus: "修改成功")
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
