//
//  ViewController.swift
//  Swift Practice # 84 NASA apod API
//
//  Created by Dogpa's MBAir M1 on 2021/9/30.
//



import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!         //顯示標題
    
    @IBOutlet weak var nasaImageView: UIImageView!  //顯示當日每日一圖
    
    @IBOutlet weak var copyrightLabel: UILabel!     //顯示著作權
    
    //自定義Function完成抓圖
    func getNASAAPIDetails () {
        
        //透過DateFormatter()將日期格式依照NASA的API來指定並將今天日期轉型成NASA指定格式
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let today = dateFormatter.string(from: Date())
        
        //將指定格式日期存入指定的API內並透過網路功能抓到JSON格式
        let urlOfNASAJSON = "https://api.nasa.gov/planetary/apod?start_date=\(today)&end_date=\(today)&api_key="
        print(urlOfNASAJSON)
        if let urlStr = urlOfNASAJSON.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let getDetailsUrl = URL(string: urlStr) {
                URLSession.shared.dataTask(with: getDetailsUrl) { data, response, error in
                    if let data = data {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        
                        do {
                            
                            //將searchResult存入抓到的資料，因為只抓一天所以Array只會有一個資料顯示內容都是抓ARRAY第0個資料
                            let searchResult = try decoder.decode([NASAJSONDetail].self, from: data)
                            DispatchQueue.main.async {
                                self.titleLabel.text = searchResult[0].title
                                if searchResult[0].copyright != nil {
                                    self.copyrightLabel.text = "copyright: \(searchResult[0].copyright!)"
                                }
                                //因為照片來源為URL所以需要再次透過data抓一次圖片下來
                                URLSession.shared.dataTask(with: searchResult[0].url) { data, response, error in
                                    if let data = data {
                                        DispatchQueue.main.async {
                                            self.nasaImageView.image = UIImage(data: data)
                                        }
                                    }
                                }.resume()
                            }
                            
                        }catch{
                            print(error)
                            print("失敗")
                        }
                    }
                }.resume()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getNASAAPIDetails()

    }

}

