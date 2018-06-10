//
//  AwardViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/1.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import SwiftyJSON

class AwardViewController: UIViewController {

    var dataArr = [[String:Any]]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RequsetData()

    }
    
    func RequsetData()  {
        DouBanProvider.request(.ssqList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data == nil {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3.0) {
                        self.RequsetData()
                    }
                    
                    return
                }
                
                let json = JSON(data!)
                let dic = json.dictionaryObject
                
                self.dataArr = dic?["data"] as! [Dictionary<String, Any>]
                //刷新表格数据
                self.tableView.reloadData()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension AwardViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 ;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : AwardTableViewCell?

        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "FirstAwardCell", for: indexPath) as? AwardTableViewCell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "AwardCell", for: indexPath) as? AwardTableViewCell

        }
        let model = dataArr[indexPath.row]
        
        cell?.period.text = "\(model["expect"] as! String)期 \(model["opentime"] as! String)"

        
        let lotteryNum = model["opencode"] as? NSString
        
        let arr = lotteryNum?.components(separatedBy: "+")
        var arr2 = (arr![0] as NSString).components(separatedBy: ",")
        arr2.append(arr![1])
        
        cell?.lotteryNum1.text = arr2[0];
        cell?.lotteryNum2.text = arr2[1];
        cell?.lotteryNum3.text = arr2[2];
        cell?.lotteryNum4.text = arr2[3];
        cell?.lotteryNum5.text = arr2[4];
        cell?.lotteryNum6.text = arr2[5];
        cell?.lotteryNumBlue.text = arr2[6];

        
        return cell!;
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 82
        }
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)

        
            
    }

    
}
