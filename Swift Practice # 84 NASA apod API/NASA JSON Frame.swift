//
//  NASA JSON Frame.swift
//  Swift Practice # 84 NASA apod API
//
//  Created by Dogpa's MBAir M1 on 2021/9/30.
//

import Foundation

//NASA JSON 指定的類型
struct NASAJSONDetail: Codable {
    let copyright : String?     //著作權可能有可能沒有
    let date : String           //每日一圖日期
    let explanation : String    //每日一圖詳細解析
    let title : String          //每日一圖標題
    let url : URL               //每日一圖照片來源
}
