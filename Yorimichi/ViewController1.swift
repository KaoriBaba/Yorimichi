//
//  ViewController1.swift
//  Yorimichi
//
//  Created by kaori baba on 2017/02/10.
//  Copyright © 2017年 kaori baba. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, UISearchBarDelegate, UIApplicationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Search Barのdelegate通知先を設定
        stationSearch0.delegate = self
        stationSearch1.delegate = self
        stationSearch2.delegate = self
        stationSearch3.delegate = self
        stationSearch4.delegate = self

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let station = Station()
    @IBOutlet weak var stationSearch0: UISearchBar!
    @IBOutlet weak var stationSearch1: UISearchBar!
    @IBOutlet weak var stationSearch2: UISearchBar!
    @IBOutlet weak var stationSearch3: UISearchBar!
    @IBOutlet weak var stationSearch4: UISearchBar!
    
    
    /*サーチバー入力時*/
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //入力が終わったらキーボードを閉じる
        view.endEditing(true)
        //入力された駅の路線を特定する
        if let searchWord = searchBar.text {
            station.searchStation(station: searchWord, num: searchBar.tag)
        }
    }
    
    /*ボタン押下時*/
    @IBAction func ramenSearch(_ sender: Any) {
        //入力された駅の間にある全ての駅を探す
        station.searchAllStation()
        //print(station.allStation)
        
        //次の画面に遷移
        performSegue(withIdentifier: "goAllStation", sender: nil)
    }
    
    //Segueで遷移する際のメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //ViewController2をインスタンス化
        let ViewController2 = segue.destination as! ViewController2
        //値を渡す
        ViewController2.allStation = station.allStation
    }

}
