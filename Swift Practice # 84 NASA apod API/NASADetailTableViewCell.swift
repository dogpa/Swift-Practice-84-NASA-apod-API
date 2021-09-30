//
//  NASADetailTableViewCell.swift
//  Swift Practice # 84 NASA apod API
//
//  Created by Dogpa's MBAir M1 on 2021/9/30.
//

import UIKit

class NASADetailTableViewCell: UITableViewCell {
    

    @IBOutlet weak var NASAImageView: UIImageView!  //顯示每日一圖照片
    
    @IBOutlet weak var dateLabel: UILabel!          //顯示每日一圖日期
    
    @IBOutlet weak var titleLabel: UILabel!         //顯示每日一圖標題
    
    @IBOutlet weak var copyrightLabel: UILabel!     //顯示每日一圖著作權
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
