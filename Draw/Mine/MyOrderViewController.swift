//
//  MyOrderViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/2.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SnapKit
import BetterSegmentedControl

class MyOrderViewController: UIViewController {
    
    let tableview = UITableView(frame: CGRect(x: 0, y: 0, width: 10, height: 10), style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        self.navigationItem.title = "我的订单"

        let control = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 64, width: view.bounds.width, height: 44.0),
            titles: ["待开奖", "待取票", "已开奖"],
            index: 1,
            options: [.backgroundColor(.white),
                      .titleColor(#colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)),
                      .indicatorViewBorderColor(#colorLiteral(red: 0.368627451, green: 0.2509803922, blue: 0.937254902, alpha: 1)),
                      .indicatorViewBorderWidth(2),
                      .selectedTitleColor(#colorLiteral(red: 0.368627451, green: 0.2509803922, blue: 0.937254902, alpha: 1)),
                      .titleFont(UIFont(name: "HelveticaNeue", size: 12.0)!),
                      .selectedTitleFont(UIFont(name: "HelveticaNeue-Medium", size: 12.0)!)]
        )
        control.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        view.addSubview(control)
        
        control.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib.init(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
        tableview.emptyDataSetSource = self;
        tableview.emptyDataSetDelegate = self;
        tableview.tableFooterView = UIView();

        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(control.snp.bottom)
        }

    }
    
    @objc func segmentValueChanged(_ sender: BetterSegmentedControl)  {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
}

extension MyOrderViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MyOrderViewController :DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "web__暂无记录")
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "暂无订单";
        
        let attributes = [kCTFontAttributeName :UIFont.boldSystemFont(ofSize: 18),kCTForegroundColorAttributeName:UIColor.darkGray]
        
        return NSAttributedString(string: text, attributes: attributes as [NSAttributedStringKey : Any]);

    }
}
