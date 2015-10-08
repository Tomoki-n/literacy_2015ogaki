//
//  BossViewController.swift
//  literacy_2015ogaki
//
//  Created by Nishinaka Tomoki on 2015/10/06.
//  Copyright © 2015年 Nishinaka Tomoki. All rights reserved.
//

import Foundation
import UIKit

class BossViewController : UIViewController {
    
    
    //Appdelegate
    var app:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    var phase:Int = 0
    
    var map:Int = 4  //0,1,2,3,4
    //var map:String = "Grassland" //Grassland,Coast,Forest,Desert,Devil
    var player:playerClass = playerClass() //プレイヤー
    var enemy:enemyClass = enemyClass()    //敵
    var quest:questClass = questClass()    //クエスト
    
    @IBOutlet var enemyimage: UIImageView!
    
    @IBOutlet var gametext: UILabel!
    @IBOutlet var questiontext: UITextView!
    @IBOutlet var t0: UILabel!
    @IBOutlet var t1: UILabel!
    @IBOutlet var t2: UILabel!
    @IBOutlet var t3: UILabel!
    @IBOutlet var HP: UILabel!
    
    var ques:[String] = []
    var a1:[String] = []
    var a2:[String] = []
    var a3:[String] = []
    var a4:[String] = []
    var ans:[String] = []
    var count :Int = 0
    var chks:Int = 0
    
    @IBAction func b1(sender: AnyObject) {
    
        check(0)
        
    }
    
    @IBAction func b2(sender: AnyObject) {
        check(1)
        
        
    }
    
    @IBAction func b3(sender: AnyObject) {
        check(2)
        
    }
    
    @IBAction func b4(sender: AnyObject) {
        check(3)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setaparam()
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func setaparam(){
        //appdelegeteのクラスを取得
        player = app.player
        enemy = app.enemy
        quest = app.quest
        map = app.map
        //敵画像を入れる
        enemy.setBoss()
        enemyimage.image = UIImage(named: enemy.Image!)
        count = map * 3
        
        //敵の名前の表示
        self.gametext.text = enemy.Name! + "が現れた！"
        
        //体力の表示
        
        self.HP.text = "HP:" + String(player.HP! * player.level!) + "/" + String(player.level! * 5)
        
        
        let JSONData :NSData = NSData(contentsOfFile: "/Users/tomoki-n/Develop/2015/iOS/literacy/literacy_2015ogaki/literacy_2015ogaki/question.json")!
        
        let json = JSON(data: JSONData)
        
        print(json)
        for i in 0...14 {
        
            if let que = json[i]["question"].string {
                ques.append(que)
            }
            if let que1 = json[i]["t0"].string {
                a1.append(que1)
            }
            if let que2 = json[i]["t1"].string {
                a2.append(que2)
            }
            if let que3 = json[i]["t2"].string {
                a3.append(que3)
            }
            if let que4 = json[i]["t3"].string {
                a4.append(que4)
            }
            if let que5 = json[i]["ans"].string {
                ans.append(que5)
            }
            
        }
        questiontext.text = ques[map * 3]
        t0.text = a1[map * 3]
        t1.text = a2[map * 3]
        t2.text = a3[map * 3]
        t3.text = a4[map * 3]
        
        NSThread.sleepForTimeInterval(1.0)
        self.gametext.text = "答えを選択して下さい"

    }
    
    
    
    func check (chk:Int) {
        
        if (chk == Int(ans[count]) && chk < 4){
            
            self.gametext.text = "正解です"
            
            count++
            chks++
            questiontext.text = ques[count]
            t0.text = a1[count]
            t1.text = a2[count]
            t2.text = a3[count]
            t3.text = a4[count]
            
            if(chk == 3){
                //画面遷移
                
            }
            
        }
        else{
             self.gametext.text = "不正解です"
            
            player.HP!--
            self.HP.text = "HP:" + String(player.HP! * player.level!) + "/" + String(player.level! * 5)
        
            
        }
        
        
        
    }
    
    
    
}