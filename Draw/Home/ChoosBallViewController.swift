//
//  ChoosBallViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/9.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit
import LeanCloud
import SVProgressHUD
import SwiftyJSON

class ChoosBallViewController: UIViewController {
    @IBOutlet weak var redCollectionView: UICollectionView!
    
    @IBOutlet weak var blueCollectionView: UICollectionView!
    
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var periods: UILabel!
    var selectedRed = [IndexPath]()
    var selectedBlue : IndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        redCollectionView.delegate = self
        redCollectionView.dataSource = self
        
        blueCollectionView.delegate = self
        blueCollectionView.dataSource = self
        
        redRandomBtn.isHidden = true
        blueRandom.isHidden = true
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical//滚动方向
        collectionLayout.itemSize = CGSize(width: 40, height: 40)//cell大小
        collectionLayout.minimumLineSpacing = 10//上下间隔
        collectionLayout.minimumInteritemSpacing = 10//左右间隔
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)//section边界
        
        
        let collectionLayout2 = UICollectionViewFlowLayout()
        collectionLayout2.scrollDirection = .vertical//滚动方向
        collectionLayout2.itemSize = CGSize(width: 40, height: 40)//cell大小
        collectionLayout2.minimumLineSpacing = 10//上下间隔
        collectionLayout2.minimumInteritemSpacing = 10//左右间隔
        collectionLayout2.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)//section边界

        
        redCollectionView.allowsMultipleSelection = true;//实现多选必须实现这个方法2、
        redCollectionView.collectionViewLayout = collectionLayout
        blueCollectionView.collectionViewLayout = collectionLayout2
        
        DouBanProvider.request(.ssqList) { result in
            if case let .success(response) = result {
                //解析数据
                
                let data = try? response.mapJSON()
                if data == nil {
                    return
                }
                
                let json = JSON(data!)
                let dic = json.dictionaryObject
                
                
                let ssqDataArr = dic?["data"] as! [Dictionary<String, Any>]
                
                let first = ssqDataArr.first
                self.periods.text = "\(Int(first!["expect"] as! String)!+1)"
            }
        }
        var timeStamp = Date().timeIntervalSince1970
        timeStamp =  timeStamp+(3600*24.0)
        
        let date = Date(timeIntervalSince1970: timeStamp)
        self.endDate.text = SLTool.dateConvertString(date: date, dateFormat: "yyyy-MM-dd  HH:mm:ss")

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        redCollectionView.reloadData()
        blueCollectionView.reloadData()

    }
    
    @IBAction func RedRandom(_ sender: Any) {

        let temp = NSArray(array: selectedRed).mutableCopy() as! NSMutableArray

        for index  in temp {
            redCollectionView.deselectItem(at: index as! IndexPath, animated: true)
            let cell = redCollectionView.cellForItem(at: index as! IndexPath) as! ChooseBallCollectionViewCell
            cell.circle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.number.textColor = .black
            
        }

        
        
        selectedRed.removeAll()

        while selectedRed.count != 6 {
            let temp = Int(arc4random()%33)
            let index = IndexPath(item: temp, section: 0)
            if !selectedRed.contains(index){
                selectedRed.append(index)
                redCollectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
                let cell = redCollectionView.cellForItem(at: index) as? ChooseBallCollectionViewCell
                cell?.circle.backgroundColor = #colorLiteral(red: 1, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
                cell?.number.textColor = .white
                
                
            }

        }

    }
    @IBOutlet weak var redRandomBtn: UIButton!
    @IBOutlet weak var blueRandom: UIButton!
    
    @IBAction func clear(_ sender: Any) {
        for index in selectedRed {
            redCollectionView.deselectItem(at: index, animated: true)
            let cell = redCollectionView.cellForItem(at: index) as! ChooseBallCollectionViewCell
            cell.circle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.number.textColor = .black
            
        }
        selectedRed.removeAll()

        if selectedBlue != nil {
            blueCollectionView.deselectItem(at: selectedBlue!, animated: true)
            let cell = blueCollectionView.cellForItem(at: selectedBlue!) as! ChooseBallCollectionViewCell
            cell.circle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.number.textColor = .black
            
            selectedBlue = nil
        }
    }
    @IBAction func submit(_ sender: Any) {
        
//        AVObject *GuangZhou = [[AVObject alloc] initWithClassName:@"City"];// 广州
//        [GuangZhou setObject:@"广州" forKey:@"name"];
//
//        AVObject *GuangDong = [[AVObject alloc] initWithClassName:@"Province"];// 广东
//        [GuangDong setObject:@"广东" forKey:@"name"];
//
//        [GuangZhou setObject:GuangDong forKey:@"dependent"];// 为广州设置 dependent 属性为广东
//
//        [GuangZhou saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            if (succeeded) {
//            // 广州被保存成功
//            }
//            }];
        
        if selectedRed.count != 6 || selectedBlue == nil {
            SVProgressHUD.showError(withStatus: "请选择6个红球1个蓝球后提交")
            return
        }
        
        let user = LCUser.current
        let order = LCObject(className: "Order")
        
        order.set("lotteryNum1", value: "\(selectedRed[0].row+1)")
        order.set("lotteryNum2", value: "\(selectedRed[1].row+1)")
        order.set("lotteryNum3", value: "\(selectedRed[2].row+1)")
        order.set("lotteryNum4", value: "\(selectedRed[3].row+1)")
        order.set("lotteryNum5", value: "\(selectedRed[4].row+1)")
        order.set("lotteryNum6", value: "\(selectedRed[5].row+1)")
        order.set("lotteryNumBlue", value: "\(selectedBlue!.row+1)")

        order.set("owner", value: user)
        
        order.save { (result) in
            switch result {
            case .success:

                SVProgressHUD.showSuccess(withStatus: "提交成功\n您的取票号为:\(order.objectId!.stringValue ?? "4358973498")")
                break
            case .failure(let error):
                print(error)
                SVProgressHUD.showError(withStatus: error.reason)
            }

        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ChoosBallViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case redCollectionView:
            return 33
        case blueCollectionView:
            return 15
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SSQBallCell", for: indexPath) as! ChooseBallCollectionViewCell
        cell.circle.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        cell.circle.layer.borderWidth = 1
        
        cell.number.text = "\(indexPath.row+1)"

        
//        switch collectionView {
//        case redCollectionView:
//
//            return cell
//        case blueCollectionView:
//
//            return cell
//        default:
//            break
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as! ChooseBallCollectionViewCell
        
        switch collectionView {
        case redCollectionView:
            if selectedRed.count < 6{
                cell.circle.backgroundColor = #colorLiteral(red: 1, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
                cell.number.textColor = .white
                selectedRed.append(indexPath)
            }
            return
        case blueCollectionView:
            if selectedBlue == nil{
                cell.circle.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                cell.number.textColor = .white
                selectedBlue = indexPath
            }

            return
        default:
            break
        }
//        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ChooseBallCollectionViewCell
        cell.circle.backgroundColor = .white
        cell.number.textColor = .black

        switch collectionView {
        case redCollectionView:
            let index = selectedRed.index(of: indexPath)
            if index != nil {
                selectedRed.remove(at: index!)
            }

            return
        case blueCollectionView:

            selectedBlue = nil
            return
        default:
            break
        }
//        collectionView.reloadData()
    }
}

