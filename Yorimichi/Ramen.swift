//
//  Ramen.swift
//  Yorimichi
//
//  Created by kaori baba on 2017/02/10.
//  Copyright © 2017年 kaori baba. All rights reserved.
//

import Foundation

class Ramen {
    var ramenList : [(id:String, name:String, url_mobile:String)] //ラーメン屋さんリスト（タプル配列）
    var viewController3 :ViewController3? = nil
    
    init() {
        ramenList = []
    }
    
    /*受け取った駅情報からリクエストURLを生成して、ぐるなびサーバにリクエストを投げる*/
    func requestURL(stationName:String) { //-> [(id:String, name:String, url_mobile:String)]
        
        //駅名をURLエンコードする
        let stationName_encode = stationName.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)
        //URLオブジェクトの生成
        let URL = Foundation.URL(string:"https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=0058bce0b77562080f24de116c6dbf25&format=json&area=AREA110&category_l=RSFST08000&category_s=RSFST08008&freeword=\(stationName_encode!)")
        //リクエストオブジェクトの生成
        let req = URLRequest(url:URL!)
        
        //セッションの接続のカスタマイズ
        //タイムアウト値・キャッシュポリシーなどを指定（今回はデフォルト値を使用）
        let configuration = URLSessionConfiguration.default
        
        //セッション情報を取り出し
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        //リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: {
            (data,response,error) in
            
            //do try catch エラーハンドリング
            do {
                
                //受け取ったJSONデータをパース（解析）して格納
                let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                
                //ラーメン屋さんリストを初期化
                self.ramenList.removeAll()
                
                //ラーメン屋さんの情報が取得できているか確認
                if let rests = json["rest"] as? [[String:Any]]{
                    
                    //取得しているラーメン屋さんの数だけ処理
                    for rest in rests {
                        //店舗ID(String)
                        guard let id = rest["id"] as? String else {
                            print("id")
                            continue
                        }
                        //店舗名称(String)
                        guard let name = rest["name"] as? String else {
                            print("name")
                            continue
                        }
                        //携帯サイトURL(String)
                        guard let url_mobile = rest["url_mobile"] as? String else {
                            print("url_mobile")
                            continue
                        }
                        //店舗画像のURL(String)
//                        guard let shop_image = rest["shop_image1"] as? String else {
//                            print("shop_image1")
//                            continue
//                        }
                        
                        //１店舗をタプルでまとめて管理
                        let ramen = (id,name,url_mobile)
                        //ラーメン屋さん配列へ追加
                        self.ramenList.append(ramen)
                    }
                }
                print("Ramen")
                print(self.ramenList)
            } catch {
                //エラー処理
                print("エラーが出ました")
            }
            self.viewController3!.ramenTableView.reloadData()
        })
        
        //タスクの実行
        task.resume()
        //return self.ramenList
    }
    
    /*レスポンス結果から各駅のNo.1ラーメンを決定*/
    /*1位以下のラーメンは、総数を押した時に別画面から一覧で見れるようにする*/
}
