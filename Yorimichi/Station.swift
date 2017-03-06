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
    //路線名探索用
    var lineName0:[String]
    var lineName1:[String]
    var lineName2:[String]
    var lineName3:[String]
    var lineName4:[String]
    //駅コード・路線コード・路線名確定用
    var selectedStationCode:[String]
    var selectedLineCode:[String]
    var selectedLineName:[String]
    //全駅格納用
    var allStation:[String]
    
    init() {
        //csv読み込み用
        let loadFile = LoadFile()
        self.csvStationArray = loadFile.loadCSV(fileName:"station_kanto_20170210")
        self.stationArray = []
        //駅コード探索用
        self.stationCode0 = ["","","","","","","","","","","","","","",""]
        self.stationCode1 = ["","","","","","","","","","","","","","",""]
        self.stationCode2 = ["","","","","","","","","","","","","","",""]
        self.stationCode3 = ["","","","","","","","","","","","","","",""]
        self.stationCode4 = ["","","","","","","","","","","","","","",""]
        //路線コード探索用
        self.lineCode0 = ["","","","","","","","","","","","","","",""]
        self.lineCode1 = ["","","","","","","","","","","","","","",""]
        self.lineCode2 = ["","","","","","","","","","","","","","",""]
        self.lineCode3 = ["","","","","","","","","","","","","","",""]
        self.lineCode4 = ["","","","","","","","","","","","","","",""]
        //路線名探索用
        self.lineName0 = ["","","","","","","","","","","","","","",""]
        self.lineName1 = ["","","","","","","","","","","","","","",""]
        self.lineName2 = ["","","","","","","","","","","","","","",""]
        self.lineName3 = ["","","","","","","","","","","","","","",""]
        self.lineName4 = ["","","","","","","","","","","","","","",""]
        //駅コード・路線コード・路線名確定用
        self.selectedStationCode = ["","","","","","","",""]
        self.selectedLineCode = ["","","",""]
        self.selectedLineName = ["","","",""]
        //全駅格納用
        self.allStation = ["","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""]
    }
    
    /*入力された駅の路線を特定する*/
    func searchStation(station:String, num:Int){
        //空のデータが飛んできたときは関連するデータを消す
        switch num {
        case 0:
        if station == "" {
            self.stationCode0 = ["","","","","","","","","","","","","","",""]
            self.lineCode0 = ["","","","","","","","","","","","","","",""]
            self.lineName0 = ["","","","","","","","","","","","","","",""]
            clearData()
            break
        }
        case 1:
        if station == "" {
            self.stationCode1 = ["","","","","","","","","","","","","","",""]
            self.lineCode1 = ["","","","","","","","","","","","","","",""]
            self.lineName1 = ["","","","","","","","","","","","","","",""]
            clearData()
            break
        }
        case 2:
        if station == "" {
            self.stationCode2 = ["","","","","","","","","","","","","","",""]
            self.lineCode2 = ["","","","","","","","","","","","","","",""]
            self.lineName2 = ["","","","","","","","","","","","","","",""]
            clearData()
            break
        }
        case 3:
        if station == "" {
            self.stationCode3 = ["","","","","","","","","","","","","","",""]
            self.lineCode3 = ["","","","","","","","","","","","","","",""]
            self.lineName3 = ["","","","","","","","","","","","","","",""]
            clearData()
            break
        }
        case 4:
        if station == "" {
            self.stationCode4 = ["","","","","","","","","","","","","","",""]
            self.lineCode4 = ["","","","","","","","","","","","","","",""]
            self.lineName4 = ["","","","","","","","","","","","","","",""]
            clearData()
            break
        }
        default:
            print("error")
        }
        
        //入力された駅の駅コードと路線コードを探す　※同じ名前の駅がある場合は全て保持する
        var j:Int = 0
        for var i:Int in 0 ... 2481 {
            stationArray = csvStationArray[i].components(separatedBy:",")
            
            if stationArray[1] == station {
                switch num {
                case 0:
                    stationCode0[j] = stationArray[0]
                    lineCode0[j] = stationArray[2]
                    lineName0[j] = stationArray[3]
                    j += 1
                case 1:
                    stationCode1[j] = stationArray[0]
                    lineCode1[j] = stationArray[2]
                    lineName1[j] = stationArray[3]
                    j += 1
                case 2:
                    stationCode2[j] = stationArray[0]
                    lineCode2[j] = stationArray[2]
                    lineName2[j] = stationArray[3]
                    j += 1
                case 3:

                    stationCode3[j] = stationArray[0]
                    lineCode3[j] = stationArray[2]
                    lineName3[j] = stationArray[3]
                    j += 1
                case 4:
                    stationCode4[j] = stationArray[0]
                    lineCode4[j] = stationArray[2]
                    lineName4[j] = stationArray[3]
                    j += 1
                default:
                    print("error")
                }
            }
        }
    
        //該当する駅コードと路線コードを探す　※前後の駅と路線コードが合致するものを選択
        //1番目と2番目の駅が入力されている・1番目と2番目の間の路線コードが不明の場合
        if stationCode1[0] != "" && selectedLineCode[0] == "" {
            for i in 0 ... 14 {
                for j in 0 ... 14 {
                    if lineCode0[i] == lineCode1[j] && lineCode0[i] != "" && lineCode1[j] != "" {
                        selectedStationCode[0] = stationCode0[i]
                        selectedStationCode[1] = stationCode1[j]
                        selectedLineCode[0] = lineCode0[i]
                        selectedLineName[0] = lineName0[i]
                    }
                }
            }
        }
        //2番目と3番目の駅が入力されている・2番目と3番目の間の路線コードが不明の場合
        if stationCode2[0] != "" && selectedLineCode[1] == "" {
            for i in 0 ... 14 {
                for j in 0 ... 14 {
                    if lineCode1[i] == lineCode2[j] && lineCode1[i] != "" && lineCode2[j] != "" {
                        selectedStationCode[2] = stationCode1[i]
                        selectedStationCode[3] = stationCode2[j]
                        selectedLineCode[1] = lineCode1[i]
                        selectedLineName[1] = lineName1[i]
                    }
                }
            }
        }
        //3番目と4番目の駅が入力されている・3番目と4番目の間の路線コードが不明の場合
        if stationCode3[0] != "" && selectedLineCode[2] == "" {
            for i in 0 ... 14 {
                for j in 0 ... 14 {
                    if lineCode2[i] == lineCode3[j] && lineCode2[i] != "" && lineCode3[j] != "" {
                        selectedStationCode[4] = stationCode2[i]
                        selectedStationCode[5] = stationCode3[j]
                        selectedLineCode[2] = lineCode2[i]
                        selectedLineName[2] = lineName2[i]
                    }
                }
            }
        }
        //　○番目と4番目の駅が入力されている・○番目と4番目の間の路線コードが不明の場合
        if stationCode4[0] != "" && selectedLineCode[3] == "" {
            for i in 0 ... 14 {
                for j in 0 ... 14 {
                    if stationCode3[0] != ""{
                        if lineCode3[i] == lineCode4[j] && lineCode3[i] != "" && lineCode4[j] != "" {
                            selectedStationCode[6] = stationCode3[i]
                            selectedStationCode[7] = stationCode4[j]
                            selectedLineCode[3] = lineCode3[i]
                            selectedLineName[3] = lineName3[i]
                            break
                        }
                    }else if stationCode2[0] != ""{
                        if lineCode2[i] == lineCode4[j] && lineCode2[i] != "" && lineCode4[j] != "" {
                            selectedStationCode[4] = stationCode2[i]
                            selectedStationCode[7] = stationCode4[j]
                            selectedLineCode[3] = lineCode2[i]
                            selectedLineName[3] = lineName2[i]
                            break
                        }
                    }else if stationCode1[0] != ""{
                        if lineCode1[i] == lineCode4[j] && lineCode1[i] != "" && lineCode4[j] != "" {
                            selectedStationCode[2] = stationCode1[i]
                            selectedStationCode[7] = stationCode4[j]
                            selectedLineCode[3] = lineCode1[i]
                            selectedLineName[3] = lineName1[i]
                            break
                        }
                    }else if stationCode0[0] != ""{
                        if lineCode0[i] == lineCode4[j] && lineCode0[i] != "" && lineCode4[j] != "" {
                            selectedStationCode[0] = stationCode0[i]
                            selectedStationCode[7] = stationCode4[j]
                            selectedLineCode[3] = lineCode0[i]
                            selectedLineName[3] = lineName0[i]
                            break
                        }
                    }
                }
            }
        }
        
    }
    
    
    /*入力された駅の間にある全ての駅を探す*/
    func searchAllStation(){

        var k:Int = 0
        
        for var j:Int in [0,2,4] {
            
            if selectedStationCode[j+1] != "" {
                if selectedStationCode[j] < selectedStationCode[j+1] {
                    for var i:Int in 0 ... 2481 {
                        stationArray = csvStationArray[i].components(separatedBy:",")
                        if selectedStationCode[j] <= stationArray[0] && selectedStationCode[j+1] > stationArray[0]{
                            allStation[k] = stationArray[1]
                            k += 1
                        }
                    }
                } else if selectedStationCode[j] > selectedStationCode[j+1] {
                    for var i:Int in (0 ... 2481).reversed() {
                        stationArray = csvStationArray[i].components(separatedBy:",")
                        if selectedStationCode[j] >= stationArray[0] && selectedStationCode[j+1] < stationArray[0]{
                            allStation[k] = stationArray[1]
                            k += 1
                        }
                    }
                }
            }
            
        }

        var j:Int = 6
        
            if selectedStationCode[j+1] != "" {
                if selectedStationCode[j] != "" {
                    if selectedStationCode[j] < selectedStationCode[j+1] {
                        for var i:Int in 0 ... 2481 {
                            stationArray = csvStationArray[i].components(separatedBy:",")
                            if selectedStationCode[j] <= stationArray[0] && selectedStationCode[j+1] >= stationArray[0]{
                                allStation[k] = stationArray[1]
                                k += 1
                            }
                        }
                    } else if selectedStationCode[j] > selectedStationCode[j+1] {
                        for var i:Int in (0 ... 2481).reversed() {
                            stationArray = csvStationArray[i].components(separatedBy:",")
                            if selectedStationCode[j] >= stationArray[0] && selectedStationCode[j+1] <= stationArray[0]{
                                allStation[k] = stationArray[1]
                                k += 1
                            }
                        }
                    }
                    
                }else if selectedStationCode[j-2] != ""{
                    if selectedStationCode[j-2] < selectedStationCode[j+1] {
                        for var i:Int in 0 ... 2481 {
                            stationArray = csvStationArray[i].components(separatedBy:",")
                            if selectedStationCode[j-2] <= stationArray[0] && selectedStationCode[j+1] >= stationArray[0]{
                                allStation[k] = stationArray[1]
                                k += 1
                            }
                        }
                    } else if selectedStationCode[j-2] > selectedStationCode[j+1] {
                        for var i:Int in (0 ... 2481).reversed() {
                            stationArray = csvStationArray[i].components(separatedBy:",")
                            if selectedStationCode[j-2] >= stationArray[0] && selectedStationCode[j+1] <= stationArray[0]{
                                allStation[k] = stationArray[1]
                                k += 1
                            }
                        }
                    }
                
                }else if selectedStationCode[j-4] != ""{
                    if selectedStationCode[j-4] < selectedStationCode[j+1] {
                        for var i:Int in 0 ... 2481 {
                            stationArray = csvStationArray[i].components(separatedBy:",")
                            if selectedStationCode[j-4] <= stationArray[0] && selectedStationCode[j+1] >= stationArray[0]{
                                allStation[k] = stationArray[1]
                                k += 1
                            }
                        }
                    } else if selectedStationCode[j-4] > selectedStationCode[j+1] {
                        for var i:Int in (0 ... 2481).reversed() {
                            stationArray = csvStationArray[i].components(separatedBy:",")
                            if selectedStationCode[j-4] >= stationArray[0] && selectedStationCode[j+1] <= stationArray[0]{
                                allStation[k] = stationArray[1]
                                k += 1
                            }
                        }
                    }
                
                }else if selectedStationCode[j-6] != ""{
                    if selectedStationCode[j-6] < selectedStationCode[j+1] {
                        for var i:Int in 0 ... 2481 {
                            stationArray = csvStationArray[i].components(separatedBy:",")
                            if selectedStationCode[j-6] <= stationArray[0] && selectedStationCode[j+1] >= stationArray[0]{
                                allStation[k] = stationArray[1]
                                k += 1
                            }
                        }
                    } else if selectedStationCode[j-6] > selectedStationCode[j+1] {
                        for var i:Int in (0 ... 2481).reversed() {
                            stationArray = csvStationArray[i].components(separatedBy:",")
                            if selectedStationCode[j-6] >= stationArray[0] && selectedStationCode[j+1] <= stationArray[0]{
                                allStation[k] = stationArray[1]
                                k += 1
                            }
                        }
                    }
                }
        
        }
        
    }

    func clearData(){
        //駅コード・路線コード・路線名確定用
        self.selectedStationCode = ["","","","","","","",""]
        self.selectedLineCode = ["","","",""]
        self.selectedLineName = ["","","",""]
        //全駅格納用
        self.allStation = ["","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""]
    }
    
}
