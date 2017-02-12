//
//  Station.swift
//  Yorimichi
//
//  Created by kaori baba on 2017/02/10.
//  Copyright © 2017年 kaori baba. All rights reserved.
//

import Foundation

class Station {
    //csv読み込み用
    var csvStationArray:[String]
    var stationArray:[String]
    //駅コード探索用
    var stationCode0:[String]
    var stationCode1:[String]
    var stationCode2:[String]
    var stationCode3:[String]
    var stationCode4:[String]
    //路線コード探索用
    var lineCode0:[String]
    var lineCode1:[String]
    var lineCode2:[String]
    var lineCode3:[String]
    var lineCode4:[String]
    //駅コード・路線コード確定用
    var selectedStationCode:[String]
    var selectedLineCode:[String]
    //全駅格納用
    var allStation:[String]
    
    init() {
        let loadFile = LoadFile()
        self.csvStationArray = loadFile.loadCSV(fileName:"station_kanto_20170210")
        self.stationArray = []
        
        self.stationCode0 = ["","","","","","","","","","","","","","",""]
        self.stationCode1 = ["","","","","","","","","","","","","","",""]
        self.stationCode2 = ["","","","","","","","","","","","","","",""]
        self.stationCode3 = ["","","","","","","","","","","","","","",""]
        self.stationCode4 = ["","","","","","","","","","","","","","",""]
        
        self.lineCode0 = ["","","","","","","","","","","","","","",""]
        self.lineCode1 = ["","","","","","","","","","","","","","",""]
        self.lineCode2 = ["","","","","","","","","","","","","","",""]
        self.lineCode3 = ["","","","","","","","","","","","","","",""]
        self.lineCode4 = ["","","","","","","","","","","","","","",""]

        self.selectedStationCode = ["","","","","","","",""]
        self.selectedLineCode = ["","","",""]
        
        self.allStation = ["","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""]
    }
    
    /*入力された駅の路線を特定する*/
    func searchStation(station:String, num:Int){

        //入力された駅の駅コードと路線コードを探す　※同じ名前の駅がある場合は全て保持する
        var j:Int = 0
        for var i:Int in 0 ... 2481 {
            stationArray = csvStationArray[i].components(separatedBy:",")
            
            if stationArray[1] == station {
                switch num {
                case 0:
                    stationCode0[j] = stationArray[0]
                    lineCode0[j] = stationArray[2]
                    j += 1
                case 1:
                    stationCode1[j] = stationArray[0]
                    lineCode1[j] = stationArray[2]
                    j += 1
                case 2:
                    stationCode2[j] = stationArray[0]
                    lineCode2[j] = stationArray[2]
                    j += 1
                case 3:
                    stationCode3[j] = stationArray[0]
                    lineCode3[j] = stationArray[2]
                    j += 1
                case 4:
                    stationCode4[j] = stationArray[0]
                    lineCode4[j] = stationArray[2]
                    j += 1
                default:
                    print("error")
                }
            }
        }
    
        //該当する駅コードと路線コードを探す　※前後の駅と路線コードが合致するものを選択
        if stationCode1[0] != "" && selectedLineCode[0] == "" {
            for i in 0 ... 14 {
                for j in 0 ... 14 {
                    if lineCode0[i] == lineCode1[j] && lineCode0[i] != "" && lineCode1[j] != "" {
                        selectedStationCode[0] = stationCode0[i]
                        selectedStationCode[1] = stationCode1[j]
                        selectedLineCode[0] = lineCode0[i]
                    }
                }
            }
        }
        
        if stationCode2[0] != "" && selectedLineCode[1] == "" {
            for i in 0 ... 14 {
                for j in 0 ... 14 {
                    if lineCode1[i] == lineCode2[j] && lineCode1[i] != "" && lineCode2[j] != "" {
                        selectedStationCode[2] = stationCode1[i]
                        selectedStationCode[3] = stationCode2[j]
                        selectedLineCode[1] = lineCode1[i]
                    }
                }
            }
        }
        
        if stationCode3[0] != "" && selectedLineCode[2] == "" {
            for i in 0 ... 14 {
                for j in 0 ... 14 {
                    if lineCode2[i] == lineCode3[j] && lineCode2[i] != "" && lineCode3[j] != "" {
                        selectedStationCode[4] = stationCode2[i]
                        selectedStationCode[5] = stationCode3[j]
                        selectedLineCode[2] = lineCode2[i]
                    }
                }
            }
        }
        
        if stationCode4[0] != "" && selectedLineCode[3] == "" {
            for i in 0 ... 14 {
                for j in 0 ... 14 {
                    if lineCode3[i] == lineCode4[j] && lineCode3[i] != "" && lineCode4[j] != "" {
                        selectedStationCode[6] = stationCode3[i]
                        selectedStationCode[7] = stationCode4[j]
                        selectedLineCode[3] = lineCode3[i]
                    }
                }
            }
        }

    }
    
    
    /*入力された駅の間にある全ての駅を探す*/
    func searchAllStation(){

        var k:Int = 0
        
        for var j:Int in [0,2,4] {
        
            if selectedStationCode[j] < selectedStationCode[j+1] {
                for var i:Int in 0 ... 2481 {
                    stationArray = csvStationArray[i].components(separatedBy:",")
                    if selectedStationCode[j] <= stationArray[0] && selectedStationCode[j+1] > stationArray[0]{
                        allStation[k] = stationArray[1]
                        k += 1
                    }
                }
            } else if selectedStationCode[j] > selectedStationCode[j+1] {
                for var i:Int in 0 ... 2481 {
                    stationArray = csvStationArray[i].components(separatedBy:",")
                    if selectedStationCode[j] >= stationArray[0] && selectedStationCode[j+1] < stationArray[0]{
                        allStation[k] = stationArray[1]
                        k += 1
                    }
                }
            }
            
        }

        var j:Int = 6
            
            if selectedStationCode[j] < selectedStationCode[j+1] {
                for var i:Int in 0 ... 2481 {
                    stationArray = csvStationArray[i].components(separatedBy:",")
                    if selectedStationCode[j] <= stationArray[0] && selectedStationCode[j+1] >= stationArray[0]{
                        allStation[k] = stationArray[1]
                        k += 1
                    }
                }
            } else if selectedStationCode[j] > selectedStationCode[j+1] {
                for var i:Int in 0 ... 2481 {
                    stationArray = csvStationArray[i].components(separatedBy:",")
                    if selectedStationCode[j] >= stationArray[0] && selectedStationCode[j+1] <= stationArray[0]{
                        allStation[k] = stationArray[1]
                        k += 1
                    }
                }
            }
        
    }

}
