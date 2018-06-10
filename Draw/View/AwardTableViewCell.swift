//
//  AwardTableViewCell.swift
//  Draw
//
//  Created by 123 on 2018/6/10.
//  Copyright © 2018年 shilin. All rights reserved.
//

import UIKit

class AwardTableViewCell: UITableViewCell {

    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var lotteryNum1: UILabel!
    
    @IBOutlet weak var lotteryNum2: UILabel!
    
    @IBOutlet weak var lotteryNum3: UILabel!
    
    @IBOutlet weak var lotteryNum4: UILabel!
        @IBOutlet weak var lotteryNum5: UILabel!
    @IBOutlet weak var lotteryNum6: UILabel!

    
    @IBOutlet weak var lotteryNumBlue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
