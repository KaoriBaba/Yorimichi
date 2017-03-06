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
        
        //Search Barの中身が空でも検索ボタンを押せるようにする
        stationSearch0.enablesReturnKeyAutomatically = false
        stationSearch1.enablesReturnKeyAutomatically = false
        stationSearch2.enablesReturnKeyAutomatically = false
        stationSearch3.enablesReturnKeyAutomatically = false
        stationSearch4.enablesReturnKeyAutomatically = false
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
    
    @IBOutlet weak var lineName0: UILabel!
    @IBOutlet weak var lineName1: UILabel!
    @IBOutlet weak var lineName2: UILabel!
    @IBOutlet weak var lineName3: UILabel!
    
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var trainImage0: UIImageView!
    @IBOutlet weak var trainImage1: UIImageView!
    @IBOutlet weak var trainImage2: UIImageView!
    
    /*サーチバー入力時*/
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //入力が終わったらキーボードを閉じる
        view.endEditing(true)
        
        //次に入力してほしいサーチバーを強調
        switch searchBar.tag {
        case 0:
            if searchBar.text != "" {
                homeImage.image = UIImage(named: "home.png")
                stationSearch4.backgroundImage = UIImage(named: "sky_line.png")
            }else{
                homeImage.image = UIImage(named: "")
                stationSearch4.backgroundImage = UIImage(named: "")
            }
        case 4:
            if searchBar.text != "" {
                trainImage0.image = UIImage(named: "train1.png")
                stationSearch1.backgroundImage = UIImage(named: "sky_line.png")
            }else{
                trainImage0.image = UIImage(named: "")
                stationSearch1.backgroundImage = UIImage(named: "")
            }
        case 1:
            if searchBar.text != "" {
                trainImage1.image = UIImage(named: "train2.png")
                stationSearch2.backgroundImage = UIImage(named: "sky_line.png")
            }else{
                trainImage1.image = UIImage(named: "")
                stationSearch2.backgroundImage = UIImage(named: "")
            }
        case 2:
            if searchBar.text != "" {
                trainImage2.image = UIImage(named: "train3.png")
                stationSearch3.backgroundImage = UIImage(named: "sky_line.png")
            }else{
                trainImage2.image = UIImage(named: "")
                stationSearch3.backgroundImage = UIImage(named: "")
            }
        default: break
        }
        
        //入力された駅の路線を特定する
        if let searchWord = searchBar.text {
            station.searchStation(station: searchWord, num: searchBar.tag)
                lineName0.text = station.selectedLineName[0]
                lineName1.text = station.selectedLineName[1]
                lineName2.text = station.selectedLineName[2]
                lineName3.text = station.selectedLineName[3]
        }
    }
    
    /*ボタン押下時*/
    @IBAction func ramenSearch(_ sender: Any) {
        //入力された駅の間にある全ての駅を探す
        station.searchAllStation()
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
