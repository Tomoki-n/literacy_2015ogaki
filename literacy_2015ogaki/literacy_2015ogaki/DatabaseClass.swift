//
//  DatabaseClass.swift
//  literacy_2015ogaki
//
//  Created by Fujisawa Tsutomu on 2015/09/19.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit

var app:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)

//装備がクラスをまたぐのでグローバル化
private let weaponList:[String] = ["はじまりの剣","漁師のモリ","狩人の弓","王者の曲刀","勇者の剣"]
private let armorList:[String]  = ["風のマント","潮風のスカーフ","深緑の帽子","ファラオの鎧","勇者の盾"]


//プレイヤーについてのクラス
class playerClass{
    //getter,setterで変更
    private var _name:String?             //名前
    private var _HP:Int?                  //HP
    private var _level:Int?               //レベル
    //外部からは変更不可
    private (set) var weapon:String?      //武器
    private (set) var armor:String?       //防具
    private (set) var weaponImage:String? //武器の画像パス
    private (set) var armorImage:String?  //防具の画像パス
    private var mapName:String?           //現在のマップ
    
    init(){
        _name   = ""
        _HP     = 5                      //HP最大値は5
        _level  = 1
        weapon  = "木の棒"                //初期武器
        armor   = "木の盾"                //初期防具
        weaponImage = "firstWeapon.png"  //初期武器パス
        armorImage  = "firstArmor.png"   //初期防具パス
        mapName = "Grassland"
    }
    
    //次の武器をゲットする
    func setNextWeapon(){
        weapon = weaponList[app.map]
        mapName = getsMap()
        weaponImage = mapName! + "Weapon.png"
    }
    
    //次の防具をセットする
    func setNextArmor(){
        armor = armorList[app.map]
        mapName = getsMap()
        armorImage = mapName! + "Armor.png"
    }
    
    //プレイヤー名
    var name:String?{
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    //HP　MAX : 5 MIN : 0
    var HP:Int?{
        get {
            return _HP
        }
        set {
            //例外処理
            if (newValue < 6) {
                if(newValue < 0){
                    _HP = 0
                }else{
                    _HP = newValue
                }
            }else{
                print("ERROR!設定HPは0~5です。この数字は設定できません。\n")
            }
        }
    }
    
    var level:Int?{
        get{
            return _level
        }
        set{
            if(newValue < 0){
                _level = 1
            }else{
                _level = newValue
            }
        }
    }
}


//敵についてのクラス
class enemyClass{
    //外部からは変更不可
    private (set) var Name :String? //敵の名前
    private (set) var Image:String? //敵の画像パス
    private let bossPositionList:[Int] = [13,13,18,3,18] //ボスの座標 12345 678910 1112131415 1617181920
    private let bossPosition:Int?
    private var mapName:String?     //現在のマップ（パス用）
    //敵の名前 Grassland,Coast,Forest,Desert,Devil
    private let enemyName:[[String]] = [["赤スライム","お化け","魔法使い","眠りの高専生","黒猫ヤマト"],
                                        ["青スライム","幽霊","魔術師","分解の高専生","双鯨デル＆トラ"],
                                        ["緑スライム","亡霊","呪術師","厳選の高専生","孤狼ウルヴァ"],
                                        ["黄スライム","悪霊","黒魔導士","奏者の高専生","火蠍ダージュラ"],
                                        ["銀スライム","死神","魔女","超能力者の高専生","大魔王"]]
    
    //初期化
    init(){
        Name    = enemyName[0][0]
        Image   = "GrasslandEnemy0.png"
        mapName = "Grassland"
        bossPosition = 0
    }
    
    
    //呼び出す都度敵を変更する（エンカウント、ランダム）
    func setEnemy(){
        //ランダムでEnemy0~4を選択 4(レア）の確率は他と比べて1/10
        var enemyNum = arc4random_uniform(31);
        if (enemyNum == 30){
            enemyNum = 3
        }else{
            enemyNum = enemyNum % 3
        }
        //名前取得
        Name = enemyName[app.map][Int(enemyNum)]
        //map名取得し、画像場所確定
        mapName = getsMap()
        Image = mapName! + "Enemy" + enemyNum.description + ".png"
    }
    
    //ボス戦前にボスの名前をセットする
    func setBoss(){
        //ボスは[map][4]名前取得
        Name = enemyName[app.map][4]
        //画像場所確定
        Image = mapName! + "Boss.png"
    }
    
    func getBossPosition() -> Int{
        return bossPositionList[app.map]
    }
    //必要ないと思われる？
    /*
    //このインスタンスを返却する
    internal func getEnemy() -> AnyObject{
    return self;
    }
    */
}


//クエストについてのクラス
class questClass{
    //itemName -> アイテムの名前 itemImage ->アイテムの画像パス 外部からは変更不可
    private (set) var weapon:String? = ""
    private (set) var armor:String? = ""
    private (set) var weaponImage:String? = ""
    private (set) var armorImage:String? = ""
    private (set) var item1:String? = ""
    private (set) var item2:String? = ""
    private (set) var item3:String? = ""
    private (set) var item1Image:String? = ""
    private (set) var item2Image:String? = ""
    private (set) var item3Image:String? = ""
    private (set) var item1Position:Int?
    private (set) var item2Position:Int?
    private (set) var item3Position:Int?
    private (set) var titleQuest:String? = ""
    private (set) var sentenceQuest:String? = ""
    private var nowQuest:Int?
    private var itemStatus:[Bool] = [false,false,false]
    private var questFinishedStatus:Int?         //0からスタートし、1なら片方、２なら両方
    
    private var mapName:String? //画像パス
    
    init(){
        mapName = "Grassland"
        item1Position = 0
        item2Position = 0
        item3Position = 0
        nowQuest = 0
        questFinishedStatus = 0
    }
    
    func setNextQuest(){
        struct Struct{
            private static var i:UInt32 = 0 //Questの状態管理 0->防具終わった(次は武器) 1->武器終わった(次は防具）]
            private static var pastMap:Int = app.map
            private static var secondFlag:Bool = false //true ->次のクエスト確定している false->始めのクエスト（クエスト未確定）
        }
        
        //mapが移ったらフラグリセット
        if (Struct.pastMap != app.map){
            Struct.secondFlag = false
            questFinishedStatus = 0
        }
        
        //すでに両方のクエストが終了している場合は実行しない。
        if(questFinishedStatus < 2){
            //secondFlagがfalseのときは、1回目のクエストを乱数で選択
            if (Struct.secondFlag == false){
                //どちらのクエストを選択するか乱数で決定
                Struct.i = arc4random_uniform(2)
                print("NEW\n")
            }
        
            //クエスト分岐
            mapName = getsMap()
            if (Struct.i == 0) {
                setWeaponQuest() //武器クエスト
                Struct.i = 1
            }else{
                setArmorQuest()  //防具クエスト
                Struct.i = 0
            }
        
            //アイテムの数に応じてステータスを確定
            switch(getQuestItemCounts()){
            case 1:
                itemStatus = [false,true,true]
                break
            case 2:
                itemStatus = [false,false,true]
                break
            case 3:
                itemStatus = [false,false,false]
                break
            default:
                break
            }
        
            Struct.secondFlag = !Struct.secondFlag
        }else{
            print("すでに両方のクエストが完了しています。\n")
        }
        Struct.pastMap = app.map
    }
    
    private func setWeaponQuest(){
        nowQuest = 1
        //アイテムの位置を設定する(2通り)
        var i:UInt32 = arc4random_uniform(2)
        var itemList:[[Int]] = [[0],[0,0],[0,0,0],[0,0,0],[0,0,0]]
        if (i == 0){
            itemList = weaponItemPositionList
        }else{
            itemList = weaponItemPositionList2
        }
        
        //アイテム数把握
        var count:Int = getQuestItemCounts()
        //アイテム数に応じてセットしていく
        switch(count){
            case 1:
                item1 = weaponItemList[app.map][0]
                item1Image = mapName! + "WeaponItem" + "0.png"
                item1Position = itemList[app.map][0]
                
                item2 = ""
                item2Image = ""
                item2Position = 0
                
                item3 = ""
                item3Image = ""
                item3Position = 0
                break
            case 2:
                item1 = weaponItemList[app.map][0]
                item2 = weaponItemList[app.map][1]
                item1Image = mapName! + "WeaponItem" + "0.png"
                item2Image = mapName! + "WeaponItem" + "1.png"
                item1Position = itemList[app.map][0]
                item2Position = itemList[app.map][1]
                
                item3 = ""
                item3Image = ""
                item3Position = 0
                break
            case 3:
                item1 = weaponItemList[app.map][0]
                item2 = weaponItemList[app.map][1]
                item3 = weaponItemList[app.map][2]
                item1Image = mapName! + "WeaponItem" + "0.png"
                item2Image = mapName! + "WeaponItem" + "1.png"
                item3Image = mapName! + "WeaponItem" + "2.png"
                item1Position = itemList[app.map][0]
                item2Position = itemList[app.map][1]
                item3Position = itemList[app.map][2]
                break
            default:
                break
        }
        //武器の名称、画像パス、クエストタイトル、クエスト本文を設定
        weapon = weaponList[app.map]
        weaponImage = mapName! + "Weapon.png"
        titleQuest = titleQuestList[app.map][0]
        sentenceQuest = sentenceQuestList[app.map][0]
    }
    
    private func setArmorQuest(){
        nowQuest = 2
        //アイテムの位置を設定する(2通り)
        var i:UInt32 = arc4random_uniform(2)
        var itemList:[[Int]] = [[0],[0,0],[0,0,0],[0,0,0],[0,0,0]]
        if (i == 0){
            itemList = armorItemPositionList
        }else{
            itemList = armorItemPositionList2
        }
        
        //アイテム数把握
        var count:Int = getQuestItemCounts()
        //アイテム数に応じてセットしていく
        switch(count){
            case 1:
                item1 = armorItemList[app.map][0]
                item1Image = mapName! + "ArmorItem" + "0.png"
                item1Position = itemList[app.map][0]
                break
            case 2:
                item1 = armorItemList[app.map][0]
                item2 = armorItemList[app.map][1]
                item1Image = mapName! + "ArmorItem" + "0.png"
                item2Image = mapName! + "ArmorItem" + "1.png"
                item1Position = itemList[app.map][0]
                item2Position = itemList[app.map][1]
                break
            case 3:
                item1 = armorItemList[app.map][0]
                item2 = armorItemList[app.map][1]
                item3 = armorItemList[app.map][2]
                item1Image = mapName! + "ArmorItem" + "0.png"
                item2Image = mapName! + "ArmorItem" + "1.png"
                item3Image = mapName! + "ArmorItem" + "2.png"
                item1Position = itemList[app.map][0]
                item2Position = itemList[app.map][1]
                item3Position = itemList[app.map][2]
                break
            default:
                break
        }
        //防具の名称、画像パス、クエストタイトル、クエスト本文を設定
        armor = armorList[app.map]
        armorImage = mapName! + "Armor.png"
        titleQuest = titleQuestList[app.map][1]
        sentenceQuest = sentenceQuestList[app.map][1]
    }
    
    //今のクエストが何個アイテムを必要としているか判断する
    func getQuestItemCounts() -> Int{
        return weaponItemList[app.map].count
    }
    
    //現在のクエストが何か返却する 1->武器 2->防具
    func getQuestEquip() -> Int{
        return nowQuest!
    }
    
    //現在のクエストが武器なのか返却
    func getQuestOfWeapon() -> Bool{
        if(nowQuest == 1){
            return true
        }else{
            return false
        }
    }
    
    //現在のアイテムが防具なのか返却
    func getQuestOfArmor() -> Bool{
        if(nowQuest == 2){
            return true
        }else{
            return false
        }
    }
    
    //アイテムを取得した時、フラグを立てるのに実行する
    func getItem(x:Int){
        itemStatus[x-1] = true
        
        //アイテムをゲットしたときにクエストが終了していれば、ステータスを1増加
        if (getQuestFinished() == true){
            if(questFinishedStatus < 2){
                questFinishedStatus = questFinishedStatus! + 1
            }
        }
    }
    
    //アイテムの取得状況を取得する
    func getItemStatus() -> [Bool]{
        return itemStatus
    }
    
    //クエストが終了したかどうか取得する
    func getQuestFinished() -> Bool{
        if(itemStatus == [true,true,true]){
            return true
        }
        return false
    }
    
    //マップにおいて両方のクエストが終了したかどうか判断する
    func getMapQuestFinished() -> Bool{
        if (questFinishedStatus == 2){
            return true
        }else{
            return false
        }
    }
    
    func getGrayMap() -> String{
        var pass:String = getsMap() + "_Gray.png"
        print(pass)
        return pass
    }
    
    
    
    
    
    
    
    //武器素材
    private let weaponItemList:[[String]] = [["ヒスイの勾玉"],
                                             ["サメの牙","アクアマリン"],
                                             ["霊木の苗木","精霊水","エメラルド"],
                                             ["蠍のしっぽ","業火の玉","ガーネット"],
                                             ["草原の思い出","砂漠の思い出","ライオンハート"]]
    
    //武器素材の位置
    private let weaponItemPositionList:[[Int]]  = [[1],[20,5],[2,9,17],[1,9,11],[2,10,12]]
    private let weaponItemPositionList2:[[Int]] = [[5],[18,3],[4,7,19],[5,7,15],[4,6,14]]
    
    //防具素材
    private let armorItemList:[[String]]  = [["そよ風のオーブ"],
                                             ["イルカのお守り","人魚の涙"],
                                             ["大樹のお守り","狼の毛皮","フクロウの羽根"],
                                             ["ミイラのお守り","星の砂","オアシスの渦"],
                                             ["海岸の思い出","森林の思い出","壊れたあいぱっど"]]
    
    //防具素材の位置
    private let armorItemPositionList:[[Int]]  = [[17],[19,7],[3,6,13],[13,2,19],[9,16,13]]
    private let armorItemPositionList2:[[Int]] = [[19],[16,9],[3,10,13],[13,4,17],[7,20,13]]
    
    //クエストタイトル
    private let titleQuestList:[[String]] = [["はじめての剣","はじめての盾"],
                                             ["海の武器といえば！","スカーフを作ろう！"],
                                             ["森で狩りをするなら！","帽子を作ろう！"],
                                             ["古代エジプトの剣！","古代エジプトの鎧！"],
                                             ["ついに魔王！最強の武器を求めて","ついに魔王！最強の防具を求めて"]]
    
    //クエスト本文
    private let sentenceQuestList:[[String]] =
    [["これから君はいろいろな敵と戦っていくだろうが、木の棒では悲しかろう。「ヒスイの勾玉」を手に入れて、剣を作るのじゃ！","これから君はいろいろな敵と戦っていくだろうが、木の盾だけでは悲しかろう。「そよ風のオーブ」を手に入れて、マントを作るのじゃ！"],
        ["ついに海岸エリアに入ったのじゃな！海岸エリアで「サメの牙」「アクアマリン」を集めて、モリを作るのじゃ！","ついに海岸エリアに入ったのじゃな！海岸エリアで「サメの牙」「アクアマリン」を集めて、モリを作るのじゃ！"],
        ["ついに森林エリアに入ったのじゃな！森林エリアで「霊木の苗木」「精霊水」「エメラルド」を集めて、弓を作るのじゃ！","つついに森林エリアに入ったのじゃな！森林エリアで「大樹のお守り」「狼の毛皮」「フクロウの羽根」を集めて、帽子を作るのじゃ！"],
        ["ついに砂漠エリアに入ったのじゃな！砂漠エリアで「蠍のしっぽ」「業火の玉」「ガーネット」を集めて、新たな剣を作るのじゃ！","ついに砂漠エリアに入ったのじゃな！砂漠エリアで「ミイラのお守り」「星の砂」「オアシスの渦」を集めて、鎧を作るのじゃ！"],
        ["ついに魔界エリアに入ったのじゃな！魔王はとても強いのじゃ！だから今までの思い出で最強の武器を作るのじゃ！魔界エリアで「草原の思い出」「砂漠の思い出」「ライオンハート」を集めて、最強の剣を作るのじゃ！","ついに魔界エリアに入ったのじゃな！魔王はとても強いのじゃ！だから今までの思い出で最強の盾を作るのじゃ！魔界エリアで「海岸の思い出」「森林の思い出」「壊れたあいぱっど」を集めて、最強の盾を作るのじゃ！"]]
}

//現在のマップを取得（マップ管理が数字になった場合使用)
private func getsMap() -> String{
    switch(app.map){
    case 0:
        return "Grassland"
    case 1:
        return "Coast"
    case 2:
        return "Forest"
    case 3:
        return "Desert"
    case 4:
        return "Devil"
    default:
        print("map番号がおかしい\n")
        return "ERROR"
    }
}