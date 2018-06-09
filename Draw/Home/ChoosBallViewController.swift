//
//  ChoosBallViewController.swift
//  Draw
//
//  Created by 123 on 2018/6/9.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit

class ChoosBallViewController: UIViewController {
    @IBOutlet weak var redCollectionView: UICollectionView!
    
    @IBOutlet weak var blueCollectionView: UICollectionView!
    
    var selectedRed = [IndexPath]()
    var selectedBlue : IndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        redCollectionView.delegate = self
        redCollectionView.dataSource = self
        
        blueCollectionView.delegate = self
        blueCollectionView.dataSource = self

        
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        redCollectionView.reloadData()
        blueCollectionView.reloadData()

    }
    
    @IBAction func RedRandom(_ sender: Any) {

        for index in selectedRed {
            let cell = redCollectionView.cellForItem(at: index) as! ChooseBallCollectionViewCell
            cell.circle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.number.textColor = .black

            redCollectionView.deselectItem(at: index, animated: true)
            selectedRed.removeAll()
        }
        
        while selectedRed.count != 6 {
            let temp = Int(arc4random()%33)
            let index = IndexPath(item: temp, section: 0)
            if !selectedRed.contains(index){
                selectedRed.append(index)
                redCollectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
                let cell = redCollectionView.cellForItem(at: index) as! ChooseBallCollectionViewCell
                cell.circle.backgroundColor = #colorLiteral(red: 1, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
                cell.number.textColor = .white


            }
        }

    }
    @IBOutlet weak var blueRandom: UIButton!
    
    @IBAction func clear(_ sender: Any) {
        for index in selectedRed {
            redCollectionView.deselectItem(at: index, animated: true)
            let cell = redCollectionView.cellForItem(at: index) as! ChooseBallCollectionViewCell
            cell.circle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.number.textColor = .black
            
            selectedRed.removeAll()
        }
        
        if selectedBlue != nil {
            blueCollectionView.deselectItem(at: selectedBlue!, animated: true)
            let cell = blueCollectionView.cellForItem(at: selectedBlue!) as! ChooseBallCollectionViewCell
            cell.circle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.number.textColor = .black
            
            selectedBlue = nil
        }
    }
    @IBAction func submit(_ sender: Any) {
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

