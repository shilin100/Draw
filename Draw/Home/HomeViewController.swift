//
//  HomeViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/1.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import SDCycleScrollView
import Moya
import SwiftyJSON
import SDWebImage
import LeanCloud

class HomeViewController: UIViewController {
    var newDataArr = [Dictionary<String, Any>]()
    var ssqDataArr = [Dictionary<String, Any>]()
    @IBOutlet weak var lotteryNum: UILabel!
    
    @IBOutlet weak var lotteryDate: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cycleview: SDCycleScrollView!
    @IBOutlet weak var drawView: UIView!
    
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var toolView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let localImages = ["劲爆活动 今年最高一次","劲爆活动 今年最高一次","劲爆活动 今年最高一次"]
        cycleview.localizationImageNamesGroup = localImages;
        
        drawView.addConnerAndShadow()
        newsView.addConnerAndShadow()
        toolView.addConnerAndShadow()

        DouBanProvider.request(.channels) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data == nil {
                    return
                }

                let json = JSON(data!)
                let dic = json.dictionaryObject

                self.newDataArr = dic?["data"] as! [Dictionary<String, Any>]
                //刷新表格数据
                self.tableView.reloadData()
            }
        }
        
        DouBanProvider.request(.ssqList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                if data == nil {
                    return
                }

                let json = JSON(data!)
                let dic = json.dictionaryObject
                
                self.ssqDataArr = dic?["data"] as! [Dictionary<String, Any>]
                //刷新表格数据
                let first = self.ssqDataArr.first
                self.period.text = "第\(Int(first!["expect"] as! String)!)期"
                self.lotteryDate.text = first!["opentime"] as? String
                
                let lotteryNum = first!["opencode"] as? NSString
                let arr2 = lotteryNum?.components(separatedBy: ",")
                
                var tempStr = ""
                
                for str in arr2!{
                    tempStr.append("\(str)    ")
                }
                
                self.lotteryNum.text = tempStr
                
            }
        }

        SLTool.loginVerfy()

    }
    
    
    @IBAction func AwardNow(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
        
    }
    @IBAction func howToPlay(_ sender: Any) {
        let vc = WebViewViewController()
        vc.URL = "http://tzz.zhcw.com/html/ssq/rules/index.shtml"
       
        vc.navigationItem.title = "玩法规则";
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        if  self.newDataArr.count > indexPath.row {
            let temp = self.newDataArr[indexPath.row]
            cell.title.text = temp["title"] as? String
            cell.date.text = temp["publishDateStr"] as? String
            let ImgUrl = (temp["imageUrls"] as? Array<String>)?.first ?? "https://img.zcool.cn/community/0113ce596f13c6a8012193a3eff959.jpg@2o.jpg"
            cell.url = temp["url"] as? String
            
            cell.img.sd_setImage(with: URL(string: ImgUrl), completed: nil)

        }
        
        cell.img.snp .updateConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 98, height: 68))
        }
        
//        cell.title.snp .updateConstraints { (make) in
//            make.top.equalTo(cell.img.snp.top)
//            make.left.equalToSuperview().offset(6)

        //        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        if cell.url != nil{
            let vc = WebViewViewController()
            vc.URL = cell.url!
            vc.navigationItem.title = "每日新闻"
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }

}
