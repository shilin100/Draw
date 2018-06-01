//
//  MineViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/1.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArr :Array<Any>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArr = [[MineCellModel(title: "我的订单", imgName: "")],
        [MineCellModel(title: "我的号码库", imgName: ""),MineCellModel(title: "修改密码", imgName: "")],
        [MineCellModel(title: "清除缓存", imgName: ""),MineCellModel(title: "关于我们", imgName: "")],
        [MineCellModel(title: "设置", imgName: "")]]
        
        
        // Do any additional setup after loading the view.
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

extension MineViewController:UITabBarDelegate,UITableViewDataSource{
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
        
        
        return cell;

    }
    
}
