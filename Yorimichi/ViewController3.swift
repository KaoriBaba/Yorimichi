//
//  ViewController3.swift
//  Yorimichi
//
//  Created by kaori baba on 2017/02/12.
//  Copyright © 2017年 kaori baba. All rights reserved.
//

import UIKit
import SafariServices

class ViewController3: UIViewController, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ramen.viewController3 = self
        //TableViewのdataSourceを設定
        ramenTableView.dataSource = self
        //Table Viewのdelegateを設定
        ramenTableView.delegate = self
        //ラーメン一覧を取得
        ramen.requestURL(stationName:stationName)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var ramenTableView: UITableView!
    var stationName:String = ""
    let ramen = Ramen()
    
    //Cellの総数を返すdatasorceメソッド（記述必須）
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) ->
        Int {
            //ラーメンリストの総数
            return ramen.ramenList.count
    }
    
    //Cellに値を設定するdatasourceメソッド（記述必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            //Cellオブジェクト（1行）を取得
            let cell = tableView.dequeueReusableCell(withIdentifier: "ramenCell", for: indexPath)
            
            //店名を設定(12文字抜き出して表示)
            let str = ramen.ramenList[indexPath.row].name
            if (str.characters.count) > 12 {
                var currentIndex = str.index(str.startIndex, offsetBy: 12)
                var subStr = str.substring(to:currentIndex)
                cell.textLabel?.text = subStr
            }else {
                cell.textLabel?.text = str
            }
            
            //コメント数を詳細情報として設定
            if (ramen.ramenList[indexPath.row].total_hit_count) != "" {
            cell.detailTextLabel?.text = ramen.ramenList[indexPath.row].total_hit_count + "point"
            }else{
                cell.detailTextLabel?.text = "0point"
            }
            
            if ramen.ramenList[indexPath.row].shop_image != "" {
                // ラーメン画像のURLを取り出す
                let url = URL(string: ramen.ramenList[indexPath.row].shop_image)
                // URLから画像を取得
                if let image_data = try? Data(contentsOf: url!) {
                    // 正常に取得できた場合は、UIImageで画像オブジェクトを生成して、Cellに画像を設定
                    cell.imageView?.image = UIImage(data: image_data)
                }
            } else {
                cell.imageView?.image = UIImage(named: "NoImage.png")
            }
            
            //設定済みのCellオブジェクトを画面に反映
            return cell
    }
    
    //Cellが選択された際に呼び出されるdelegateメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ハイライト解除
        tableView.deselectRow(at: indexPath, animated: true)
        // URLをstring → URL型に変換
        let urlToLink = URL(string: ramen.ramenList[indexPath.row].url_mobile)
        // SFSafariViewを開く
        let safariViewController = SFSafariViewController(url: urlToLink!)
        // delegateの通知先を自分自身
        safariViewController.delegate = self
        // SafariViewが開かれる
        present(safariViewController, animated: true, completion: nil)
    }
    
}
