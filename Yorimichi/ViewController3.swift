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
    // var ramenList : [(id:String, name:String, url_mobile:String)] = [] //ラーメン屋さんのリスト（タプル配列）
    
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
            //店名を設定
            cell.textLabel?.text = ramen.ramenList[indexPath.row].name
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
