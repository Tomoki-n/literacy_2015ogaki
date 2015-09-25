//
//  DatabaseClass.swift
//  literacy_2015ogaki
//
//  Created by Fujisawa Tsutomu on 2015/09/19.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit

var app:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)

let weaponList[String] = ["はじまりの剣","漁師のモリ","狩人の弓","王者の曲刀","勇者の剣"]
let armorList[String]  = ["風のマント","潮風のスカーフ","深緑の帽子","ファラオの鎧","勇者の盾"]


//プレイヤーについてのクラス
class playerClass{
    
    var Name:String?   //プレイヤー名
    var HP:Int?        //HP　MAX : 5 MIN : 0
    var weapon:String? //装備武器
    var armor:String?  //装備防具
    
    init(){
        Name   = "YAMAGUCHI"
        HP     = 5
        weapon = weaponList[0]
        armor  = armorList[0]
    }
    
}

//敵についてのクラス
class enemyClass{
    //敵の名前 Grassland,Coast,Forest,Desert,Devil
    private let enemyName:[[String]] = [["赤スライム","お化け","魔法使い","眠りの高専生","黒猫ヤマト"],
                                        ["青スライム","幽霊","魔術師","分解の高専生","双鯨デル＆トラ"],
                                        ["緑スライム","亡霊","呪術師","厳選の高専生","孤狼ウルヴァ"],
                                        ["黄スライム","悪霊","黒魔導士","奏者の高専生","火蠍ダージュラ"],
                                        ["銀スライム","死神","魔女","超能力者の高専生","大魔王"]]
    
    //外部からは読み込み専用
    private (set) var Name :String? //敵の名前
    private (set) var Image:String? //敵の画像パス
    private var mapName:String?     //現在のマップ（パス用）
    
    //初期化
    init(){
        Name    = enemyName[0][0]
        Image   = "GrasslandEnemy0.png"
        mapName = "Grassland"
    }
    
    
    //呼び出す都度敵を変更する（エンカウント、ランダム）
    func setEnemy(){
        //ランダムでEnemy0~4を選択 4(レア）の確率は他と比べて1/10
        var enemyNum = arc4random_uniform(31);
        println(enemyNum)
        if (enemyNum == 30){
            enemyNum = 3
        }else{
            enemyNum = enemyNum % 3
        }
        //名前取得
        Name = enemyName[app.map][Int(enemyNum)]
        //map名取得し、画像場所確定
        getsMap()
        Image = mapName! + "Enemy" + enemyNum.description + ".png"
    }
    
    //ボス戦前にボスの名前をセットする
    func setBoss(){
        //ボスは[map][4]名前取得
        Name = enemyName[app.map][4]
        //画像場所確定
        Image = mapName! + "Boss.png"
    }
    
    //現在のマップを取得（マップ管理が数字になった場合使用)
    private func getsMap(){
        switch(app.map){
        case 0:
            mapName = "Grassland"
            break
        case 1:
            mapName = "Coast"
            break
        case 2:
            mapName = "Forest"
            break
        case 3:
            mapName = "Desert"
            break
        case 4:
            mapName = "Devil"
            break
        default:
            break
        }
    }
    //必要ないと思われる？
    /*
    //このインスタンスを返却する
    internal func getEnemy() -> AnyObject{
    return self;
    }
    */
}