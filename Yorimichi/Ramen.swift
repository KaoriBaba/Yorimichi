//
//  Ramen.swift
//  Yorimichi
//
//  Created by kaori baba on 2017/02/10.
//  Copyright © 2017年 kaori baba. All rights reserved.
//

import Foundation

class Ramen {
    var ramenList : [(id:String, name:String, url_mobile:String, shop_image:String, total_hit_count:String)] //ラーメン屋さんリスト（タプル配列）
    var viewController3 :ViewController3? = nil
    
    init() {
        ramenList = []
    }
    
    /*受け取った駅情報からリクエストURLを生成して、ぐるなびサーバにリクエストを投げる*/
    /*レスポンス結果から各ラーメン屋さんの店舗IDを特定し、その店舗の応援コメント数を取得する*/
    func requestURL(stationName:String) {
        
        //駅名をURLエンコードする
        let stationName_encode = stationName.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)
        //レストラン検索APIのURLオブジェクトの生成
        let URL = Foundation.URL(string:"https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=0058bce0b77562080f24de116c6dbf25&format=json&area=AREA110&category_l=RSFST08000&category_s=RSFST08008&freeword=\(stationName_encode!)")
        //レストラン検索APIのリクエストオブジェクトの生成
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
                            continue
                        }
                        //店舗名称(String)
                        guard let name = rest["name"] as? String else {
                            continue
                        }
                        //携帯サイトURL(String)
                        guard let url_mobile = rest["url_mobile"] as? String else {
                            continue
                        }
                        //店舗画像のURL(String)
                        guard let image_url = rest["image_url"] as? [String:Any] else {
                            continue
                        }
                        var shop_image:String = ""
                        if image_url["shop_image1"] as? String != nil {
                            shop_image = image_url["shop_image1"] as! String
                        }
                    
        //-------------------------------
        var respons:[String:Any] = [:]
        var total_hit_count:String = ""
        //応援口コミAPIのURLオブジェクトの生成
        let URL2 = Foundation.URL(string:"https://api.gnavi.co.jp/PhotoSearchAPI/20150630/?keyid=0058bce0b77562080f24de116c6dbf25&format=json&shop_id=\(id)")
        //応援口コミAPIのリクエストオブジェクトの生成
        let req2 = URLRequest(url:URL2!)
                    
        //セッションの接続のカスタマイズ
        //タイムアウト値・キャッシュポリシーなどを指定（今回はデフォルト値を使用）
        let configuration2 = URLSessionConfiguration.default
        //セッション情報を取り出し
        let session2 = URLSession(configuration: configuration2, delegate: nil, delegateQueue: OperationQueue.main)
        //リクエストをタスクとして登録
        let task2 = session2.dataTask(with: req2, completionHandler: {
                                                (data,response,error) in
            //do try catch エラーハンドリング
            do {
                //受け取ったJSONデータをパース（解析）して格納
                let json2 = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
//                print("json2--------------------")
//                print(json2)
                //ラーメン屋さんの情報が取得できているか確認
                //該当件数
                if json2["respons"] as? [String:Any] != nil {
                    respons = json2["respons"] as! [String:Any]
                }
                if respons["total_hit_count"] as? String != nil {
                    total_hit_count = respons["total_hit_count"] as! String
                }
                } catch {
                    //エラー処理
                    print("エラーが出ました")
                }
            })
        //タスクの実行
        task2.resume()
        //-------------------------------
                        
                        //１店舗をタプルでまとめて管理
                        let ramen = (id,name,url_mobile,shop_image,total_hit_count)
                        //ラーメン屋さん配列へ追加
                        self.ramenList.append(ramen)
                        
                        }
                }
                print("ramenList")
                print(self.ramenList)
            } catch {
                //エラー処理
                print("エラーが出ました")
            }
            self.viewController3!.ramenTableView.reloadData()
        })
        //タスクの実行
        task.resume()
    }
    
}
