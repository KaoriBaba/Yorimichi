//
//  ViewController2.swift
//  Yorimichi
//
//  Created by kaori baba on 2017/02/12.
//  Copyright © 2017年 kaori baba. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //TableViewのdataSourceを設定
        stationTableView.dataSource = self
        //Table Viewのdelegateを設定
        stationTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var stationTableView: UITableView!
    var allStation:[String] = []
    var stationName:String = ""
    
    //Cellの総数を返すdatasorceメソッド（記述必須）
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return 30 //駅リストの総数
    }
    
    //Cellに値を設定するdatasourceメソッド（記述必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            //Cellオブジェクト（1行）を取得
            let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath)
            //駅名を設定
            cell.textLabel?.text = allStation[indexPath.row]
            //設定済みのCellオブジェクトを画面に反映
            return cell
    }
    
    //Cellが選択された際に呼び出されるdelegateメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ハイライトの解除
        tableView.deselectRow(at: indexPath, animated: true)
        //駅を次のページに渡す
        self.stationName = allStation[indexPath.row]+"駅"
        //次の画面に遷移
        performSegue(withIdentifier: "goAllRamen", sender: nil)
    }
    
    //Segueで遷移する際のメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //ViewController3をインスタンス化
        let ViewController3 = segue.destination as! ViewController3
        //値を渡す
        ViewController3.stationName = self.stationName
    }
    
}
