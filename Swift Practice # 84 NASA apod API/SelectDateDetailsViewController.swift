//
//  SelectDateDetailsViewController.swift
//  Swift Practice # 84 NASA apod API
//
//  Created by Dogpa's MBAir M1 on 2021/9/30.
//

import UIKit

class SelectDateDetailsViewController: UIViewController {
    
    var intFromPerviousPage: Int!                       //上一頁的選到的row的數值
    var JSONArrayFromPerviousPag : [NASAJSONDetail]!    //上一頁整個的JSON資料
    
    @IBOutlet weak var selectImageView: UIImageView!    //每日一圖照片
    
    @IBOutlet weak var selectDateLabel: UILabel!        //每日一圖日期
    
    @IBOutlet weak var selectTitleLabel: UILabel!       //每日一圖標題
    
    @IBOutlet weak var selectCopyrightLabel: UILabel!   //每日一圖著作權
    
    @IBOutlet weak var selectExplanationLabel: UILabel! //每日一圖詳細解說
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //指派每一個OUtlet顯示的內容，並且再次從url抓照片下來顯示
        selectDateLabel.text = JSONArrayFromPerviousPag[intFromPerviousPage].date
        selectTitleLabel.text = JSONArrayFromPerviousPag[intFromPerviousPage].title
        selectExplanationLabel.text = JSONArrayFromPerviousPag[intFromPerviousPage].explanation
        if JSONArrayFromPerviousPag[intFromPerviousPage].copyright != nil {
            selectCopyrightLabel.text = "©\(String(describing: JSONArrayFromPerviousPag![intFromPerviousPage!].copyright!))"
        }
        URLSession.shared.dataTask(with: JSONArrayFromPerviousPag[intFromPerviousPage].url) { data, response , error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.selectImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
