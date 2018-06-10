//
//  NumberLibViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/9.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import LeanCloud
import DZNEmptyDataSet
import SVProgressHUD

class NumberLibViewController: UIViewController {

    var dataArr = [LCObject]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        
        let libs = LCQuery(className: "Order")

        if libs.count().intValue > 0 {
            libs.whereKey("createdAt", .ascending)
            libs.find { (result) in
                switch result {
                case .success(let model):

                    self.dataArr =  model.lcArray.arrayValue as! [LCObject]
                    self.tableView.reloadData()
                break // 查询成功
                case .failure(let error):
                    print(error)
                    SVProgressHUD.showError(withStatus: error.reason)
                }

            }

            
        }else{
            
        }

        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension NumberLibViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "web__暂无记录")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "暂无数据")
    }
}

extension NumberLibViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 ;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let   cell = tableView.dequeueReusableCell(withIdentifier: "NumLibCell", for: indexPath) as? AwardTableViewCell
        let model = dataArr[indexPath.row];
        let query = LCQuery(className: "Order")
        query.get((model.objectId?.stringValue)!){ result in
            switch result {
            case .success(let todo):
                cell?.lotteryNum1.text = todo.get("lotteryNum1")!.stringValue
                cell?.lotteryNum2.text = todo.get("lotteryNum2")!.stringValue
                cell?.lotteryNum3.text = todo.get("lotteryNum3")!.stringValue
                cell?.lotteryNum4.text = todo.get("lotteryNum4")!.stringValue
                cell?.lotteryNum5.text = todo.get("lotteryNum5")!.stringValue
                cell?.lotteryNum6.text = todo.get("lotteryNum6")!.stringValue
                cell?.lotteryNumBlue.text = todo.get("lotteryNumBlue")!.stringValue
                let date = todo.get("createdAt")!.dateValue
                
                cell?.period.text = SLTool.dateConvertString(date: date!, dateFormat: "yyyy-MM-dd HH:mm:ss")
                
            case .failure(let error):
                print(error)
            }
        
        }
        
        
        
        return cell!;
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
}

