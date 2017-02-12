//
//  Ramen.swift
//  Yorimichi
//
//  Created by kaori baba on 2017/02/10.
//  Copyright © 2017年 kaori baba. All rights reserved.
//

import Foundation

/*受け取った駅情報からリクエストURLを生成*/
//駅名
var stationName:String = "六郷土手"
//駅名をURLエンコードする
let stationName_encode = stationName.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)
//URLオブジェクトの生成
let URL = Foundation.URL(string: "http://www.sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(stationName_encode!)&max=10&order=r")
//リクエストオブジェクトの生成
let req = URLRequest(url:URL!)


/*レスポンス結果から各駅のNo.1ラーメンを決定*/
/*1位以下のラーメンは、総数を押した時に別画面から一覧で見れるようにする*/
