//
//  ChooseDateViewController.swift
//  Swift Practice # 84 NASA apod API
//
//  Created by Dogpa's MBAir M1 on 2021/9/30.
//

import UIKit

class ChooseDateViewController: UIViewController {
    
    @IBOutlet weak var startDatePicker: UIDatePicker!   //開始日期DatePicker
    
    @IBOutlet weak var endDatePicker: UIDatePicker!     //結束日期DatePicker
    
    @IBOutlet weak var watchImageButton: UIButton!      //button
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //透過程式碼讓button有圓邊
        let totalYLenthOfButton = watchImageButton.frame.maxY - watchImageButton.frame.minY
        watchImageButton.layer.cornerRadius = CGFloat(totalYLenthOfButton/2)
       
    }
    
    //IBSegueAction傳日期資料
    @IBSegueAction func showSelectDateImage(_ coder: NSCoder) -> ShowChooseNASAImageTableViewController? {
        //指派controller存入下一頁ShowChooseNASAImageTableViewController
        let controller = ShowChooseNASAImageTableViewController(coder: coder)
        
        //透過DateFormatter()取得日期格式後並轉為字串比較，若開始日期晚於結束日期 或結束日期晚於今天，跳出警告

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMdd"
        if let selectStartToInt = Int(dateFormatter.string(from: startDatePicker.date)), let selectEndToInt = Int(dateFormatter.string(from: endDatePicker.date)), let todayToInt = Int(dateFormatter.string(from: Date())){
            if selectStartToInt > selectEndToInt {
                let alertController = UIAlertController(title: "結束日期大於開始日期" , message: "請返回原畫面再次確認", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "了解", style: .default)
                                alertController.addAction(okAction)
                                present(alertController, animated: true, completion: nil)
            }else if selectEndToInt > todayToInt {
                let alertController = UIAlertController(title: "結束日期大於開始今天" , message: "請返回原畫面再次確認", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "了解", style: .default)
                                alertController.addAction(okAction)
                                present(alertController, animated: true, completion: nil)
            }
            
            //若日期正常，再次透過DateFormatter()將日期轉型為NASA JSON指定格式後傳資料給下一頁ShowChooseNASAImageTableViewController
            else{
                dateFormatter.dateFormat = "YYYY-MM-dd"
                controller?.startString = dateFormatter.string(from: startDatePicker.date)
                controller?.endString = dateFormatter.string(from: endDatePicker.date)
    
            }
        }
        return controller
        
    }
    

}
