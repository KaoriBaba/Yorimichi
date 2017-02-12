//
//  ViewController3.swift
//  Yorimichi
//
//  Created by kaori baba on 2017/02/12.
//  Copyright © 2017年 kaori baba. All rights reserved.
//

import UIKit

class ViewController3: UIViewController, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //TableViewのdataSourceを設定
        ramenTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var ramenTableView: UITableView!
  
    //ラーメンリスト（タプル配列）
    var ramenList : [(ramen:String, test:String)] = []
    
    //Cellの総数を返すdatasorceメソッド。必ず記述する
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) ->
        Int {
            //ラーメンリストの総数
            return ramenList.count
    }
    
    //Cellに値を設定するdatasourceメソッド。必ず記述する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            //今回表示を行う、Cellオブジェクト（1行）を取得する
            let cell = tableView.dequeueReusableCell(withIdentifier: "ramenCell", for: indexPath)
            //設定済みのCellオブジェクトを画面に反映
            return cell
    }
    
}
