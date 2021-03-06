//
//  MineViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/1.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import SVProgressHUD
import LeanCloud


class MineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var username: UILabel!
    
    var dataArr :Array<Any>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArr = [[MineCellModel(title: "我的订单", imgName: "订单")],
        [MineCellModel(title: "我的号码库", imgName: "库存分类"),MineCellModel(title: "修改密码", imgName: "修改密码")],
        [MineCellModel(title: "清除缓存", imgName: "清理"),MineCellModel(title: "关于我们", imgName: "关于我们")],
        [MineCellModel(title: "设置", imgName: "主页-设置")]]
        
        
//        let user = LCUser.current
//        username.text = user?.username?.stringValue
        
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //设置导航栏背景透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //重置导航栏背景
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

struct MineCellModel {
    var title :String?
    var imgName : String?
}

extension MineViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array : Array = dataArr?[section] as? Array<Any> {
            return array.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineCell", for: indexPath) as! MineTableViewCell
        
        let array = dataArr![indexPath.section] as! Array<MineCellModel>
        let model = array[indexPath.row]
        cell.titleLabel.text = model.title
        cell.img.image = UIImage(named: model.imgName!)
        
        return cell;

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            if(indexPath.row == 0){
                let vc = MyOrderViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case 1:
            if(indexPath.row == 1){
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePSWViewController")
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            if(indexPath.row == 0){
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NumberLibViewController")
                self.navigationController?.pushViewController(vc, animated: true)
                
            }

            break
        case 2:
            if indexPath.row == 0{
                SVProgressHUD.show(withStatus: "清除中")
                let queue1 = DispatchQueue(label: "queue1")
                // 让其延迟0.5秒操作
                queue1.asyncAfter(deadline: .now() + 0.5) {
                    SVProgressHUD.showSuccess(withStatus: "清除成功")
                    SVProgressHUD.dismiss(withDelay: 0.5)
                }

            }
            if indexPath.row == 1 {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutUsViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 3:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsTableViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
    }
    
}
