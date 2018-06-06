//
//  HomeViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/1.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import SDCycleScrollView
import RxSwift
import Moya

class HomeViewController: UIViewController {
    let disposeBag = DisposeBag()

    
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

        let provider = MoyaProvider<ApiManager>();
        
        provider.request(.login(username: "haha", password: "123456", token: "qwe")) { (result) in
            if result.error == nil{
                print(result.value);
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


