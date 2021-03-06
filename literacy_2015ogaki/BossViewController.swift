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
    let bgm = Sound()
    let bgm1 = Sound()
    
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
    
    var flag:Bool = false
    
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
       
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        bgm.ids(1)
        bgm.vol(0.5)
        bgm.infstart()
        setaparam()
        
        if self.flag {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func setaparam(){
        //appdelegeteのクラスを取得
        player = app.player
        enemy = app.enemy
        quest = app.quest
        map = app.map
        //敵画像を入れる
        enemy.setBoss()
        switch app.map {
        case 0:
            enemyimage.image = UIImage(named: "GrasslandBoss.png")
            break
        case 1:
            enemyimage.image = UIImage(named: "CoastBoss.png")
            break
        case 2:
            enemyimage.image = UIImage(named: "ForestBoss.png")
            break
        case 3:
            enemyimage.image = UIImage(named: "DesertBoss.png")
            break
        case 4:
            enemyimage.image = UIImage(named: "DevilBoss.png")
            break
        default:
            break
        }
        count = map * 3
        
        //敵の名前の表示
        self.gametext.text = enemy.Name! + "が現れた！"
        
        //体力の表示
        
        self.HP.text = "HP:" + String(player.HP! * player.level!) + "/" + String(player.level! * 5)
        drawhp()
        let path = NSBundle.mainBundle().pathForResource("question", ofType: "json")!
        
        
        let JSONData = NSData(contentsOfFile: path)!
        
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
            bgm1.ids(14)
            bgm1.start()
            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: false)
            
            count++
            chks++
            if(chks == 3){
                //画面遷移
                bgm1.ids(3)
                bgm1.start()
               
                    NSTimer.scheduledTimerWithTimeInterval(0.0, target: self, selector: Selector("returnv:"), userInfo: nil, repeats: false)
                
            }
            else{
                questiontext.text = ques[count]
                t0.text = a1[count]
                t1.text = a2[count]
                t2.text = a3[count]
                t3.text = a4[count]
            }
            
            
        }
        else{
            self.gametext.text = "不正解です"
            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: false)
            bgm1.ids(2)
            bgm1.start()
            
            
            player.HP! -= 3
            drawhp()
            self.HP.text = "HP:" + String(player.HP! * player.level!) + "/" + String(player.level! * 5)
            
            if player.HP == 0{
                NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: Selector("returnv:"), userInfo: nil, repeats: false);
                
                //HPがゼロ
            }
            
        }
        
        
        
    }
    
    
    func onUpdate(timer: NSTimer) {
        self.gametext.text = "答えを選んでね"
    }
    func returnv(timer: NSTimer) {
        app.player = player
        app.enemy = enemy
        app.quest = quest
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.flag = true
        appDelegate.boss = true
        bgm.stop()
        
        if player.HP != 0 && app.map == 4{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else if player.HP != 0 {
            self.performSegueWithIdentifier("story", sender: self)
            print(1)
        }
        else{
            self.dismissViewControllerAnimated(true, completion: nil)
            print(222)
        }
    }
    
    @IBOutlet var hp0: UIImageView!
    @IBOutlet var hp1: UIImageView!
    @IBOutlet var hp2: UIImageView!
    @IBOutlet var hp3: UIImageView!
    @IBOutlet var hp4: UIImageView!
    
    func drawhp(){
        if app.player.HP == 5 {
            hp0.image = UIImage(named:"hp_teki")
            hp1.image = UIImage(named:"hp_teki")
            hp2.image = UIImage(named:"hp_teki")
            hp3.image = UIImage(named:"hp_teki")
            hp4.image = UIImage(named:"hp_teki")
        }
        else if app.player.HP == 4 {
            hp0.image = UIImage(named:"hp_teki")
            hp1.image = UIImage(named:"hp_teki")
            hp2.image = UIImage(named:"hp_teki")
            hp3.image = UIImage(named:"hp_teki")
            hp4.image = UIImage(named:"hp_mikata")
        }
        else if app.player.HP == 3 {
            hp0.image = UIImage(named:"hp_teki")
            hp1.image = UIImage(named:"hp_teki")
            hp2.image = UIImage(named:"hp_teki")
            hp3.image = UIImage(named:"hp_mikata")
            hp4.image = UIImage(named:"hp_mikata")
        }
        else if app.player.HP == 2 {
            hp0.image = UIImage(named:"hp_teki")
            hp1.image = UIImage(named:"hp_teki")
            hp2.image = UIImage(named:"hp_mikata")
            hp3.image = UIImage(named:"hp_mikata")
            hp4.image = UIImage(named:"hp_mikata")
        }
        else if app.player.HP == 1 {
            hp0.image = UIImage(named:"hp_teki")
            hp1.image = UIImage(named:"hp_mikata")
            hp2.image = UIImage(named:"hp_mikata")
            hp3.image = UIImage(named:"hp_mikata")
            hp4.image = UIImage(named:"hp_mikata")
        }
        else if app.player.HP == 0 {
            hp0.image = UIImage(named:"hp_mikata")
            hp1.image = UIImage(named:"hp_mikata")
            hp2.image = UIImage(named:"hp_mikata")
            hp3.image = UIImage(named:"hp_mikata")
            hp4.image = UIImage(named:"hp_mikata")
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(232)
        if segue.identifier == "story" {
            print(12324)
            self.flag = true
        }
    }
    
    deinit {
        print("bossViewController")
    }
    
}