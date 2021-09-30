//
//  ShowChooseNASAImageTableViewController.swift
//  Swift Practice # 84 NASA apod API
//
//  Created by Dogpa's MBAir M1 on 2021/9/30.
//

import UIKit

class ShowChooseNASAImageTableViewController: UITableViewController {
    
    var startString : String!   //開始日期的字串，從上一頁取得
    var endString : String!     //結束日期的字串，從上一頁取得
    
    var saveJSONArray = [NASAJSONDetail]()      //存入ＪＳＯＮ資料使用
    
    //自定義Function
    func getNASAAPIDetails () {
        
        //將上一頁指定日期加入API網址內透過網路取得ＪＳＯＮ資料
        let urlOfNASAJSON = "https://api.nasa.gov/planetary/apod?start_date=\(startString!)&end_date=\(endString!)&api_key="
        print(urlOfNASAJSON)
        if let urlStr = urlOfNASAJSON.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let getDetailsUrl = URL(string: urlStr) {
                URLSession.shared.dataTask(with: getDetailsUrl) { data, response, error in
                    if let data = data {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        do {
                            let searchResult = try decoder.decode([NASAJSONDetail].self, from: data)
                            self.saveJSONArray = searchResult
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                }
                            print(searchResult)
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
        getNASAAPIDetails ()
        //print(startString!,endString!)  //列印測試
        
    }

    // MARK: - Table view data source
    //顯示區域數
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //顯示row總數 依照saveJSONArray抓出的資料總數決定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return saveJSONArray.count
    }

    //透過自定義的UITableViewCell來顯示資料格式
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NASADetailTableViewCell", for: indexPath) as! NASADetailTableViewCell
        
        cell.copyrightLabel.text = saveJSONArray[indexPath.row].copyright
        cell.dateLabel.text = saveJSONArray[indexPath.row].date
        cell.titleLabel.text = saveJSONArray[indexPath.row].title
        URLSession.shared.dataTask(with: saveJSONArray[indexPath.row].url) { data, response , error in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.NASAImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
        return cell
    }
    
    //傳資料給下一頁
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "selectDateDetailsInfo", sender: nil)
    }
    
    //傳資料給下一頁使用用來顯示更詳細的每日一圖
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectDateDetailsInfo" {
            if let selectInfoView = segue.destination as? SelectDateDetailsViewController{
                let selectIndexPath = self.tableView.indexPathForSelectedRow
                
                if let selectRow = selectIndexPath?.row {
                    selectInfoView.intFromPerviousPage = selectRow
                    selectInfoView.JSONArrayFromPerviousPag = saveJSONArray
                    
                }
            }
        }
    }
    
    
}
