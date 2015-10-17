

//
//  ViewController.swift
//  literacy_2015ogaki
//
//  Created by Nishinaka Tomoki on 2015/09/14.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit
import AVFoundation

class jyankenViewController: UIViewController, AVAudioPlayerDelegate {
    
    //Appdelegate
    var app:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    var phase:Int = 0
    var n:UInt32!
    var count:UInt32 = 0
    var te:UInt32 = 0
    let bgm = Sound()
    let bgm1 = Sound()
    //現在マップ
    var map:Int = 0  //0,1,2,3,4
    //var map:String = "Grassland" //Grassland,Coast,Forest,Desert,Devil
    
    var player:playerClass = playerClass() //プレイヤー
    var enemy:enemyClass = enemyClass()    //敵
    var quest:questClass = questClass()    //クエスト
    
    @IBOutlet var enemyimage: UIImageView!
    
    @IBOutlet var enemyhand: UIImageView!
    @IBOutlet var gametext: UILabel!
    @IBOutlet var HP: UILabel!
    
    @IBOutlet var gu: UIButton!
    @IBOutlet var choki: UIButton!
    @IBOutlet var pa: UIButton!
    
    
    @IBAction func pushpa(sender: AnyObject) {
        
        if phase == 1 {
            te = 3
            janken_check(3)
            
            
        }
        
        
    }
    @IBAction func pushchoki(sender: AnyObject) {
        if phase == 1 {
            te = 2
            janken_check(2)
            
            
            
            
        }
        
        
    }
    
    @IBAction func pushgu(sender: AnyObject) {
        
        if phase == 1 {
            te = 1
            janken_check(1)
            
            
            
            
            
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        btnno()
        
        
        bgm.ids(0)
        bgm.infstart()
        
        start()
               
    }
    
    
    override func viewDidAppear(animated: Bool) {
      drawhp()
        
        
        
       
         // NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("onUpdate1:"), userInfo: nil, repeats: false);
         setaparam()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func btnno(){
        
        self.gu.enabled = false
        self.choki.enabled = false
        self.pa.enabled = false
    }
    
    func btnyes(){
        
        self.gu.enabled = true
        self.choki.enabled = true
        self.pa.enabled = true
        
    }
    func setaparam(){
     //appdelegeteのクラスを取得
        player = app.player
        enemy = app.enemy
        quest = app.quest
        
        //敵画像を入れる
        enemy.setEnemy()
        enemyimage.image = UIImage(named: enemy.Image!)
        
        
        //敵の名前の表示
        self.gametext.text = enemy.Name! + "が現れた！"
        
        //体力の表示
        //未完成（levelが実装されていないため）
        let level:Int = 10
        self.HP.text = "HP:" + String(player.HP!*level) + "/" + String(level*5)
        
        
    }
    
    func janken_check(data: UInt32){
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        phase = 0
        
        // 画像を再表示
        n = arc4random() % 3 + 1;
        var res = 0
        setenemyhand(n)
        
        
        if(n == data){
            // あいこ
            res = 0
            
             setenemyhand(data)
            
        }else{
            switch(data){
            case 1:
                if(n == 2){
                    res = 1
                }else{
                    res = -1
                }
                break
                
            case 2:
                if(n == 3){
                    res = 1
                }else{
                    res = -1
                }
                break
                
            default:
                if(n == 1){
                    res = 1
                }else{
                    res = -1
                }
                break
            }
        }
        if count == 2 && res == -1{
            janken_check(te)
        }
        else{
        // しょうぶけっか
        var str = ""
        switch(res){
        case 1:
            str = "あなたの勝ちです！"
            
            self.gametext.text = str
            btnno()
            bgm1.ids(12)
            bgm1.start()
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("returnv:"), userInfo: nil, repeats: false);
            break
        case -1:
            str = "あなたの負けです！"
            count++
            self.gametext.text = str
            btnno()
            bgm1.ids(12)
            bgm1.start()
            
            player.HP! -= 1
            drawhp()
            if player.HP == 0{
                bgm1.ids(11)
                bgm1.start()
                NSTimer.scheduledTimerWithTimeInterval(1.1, target: self, selector: Selector("returnv:"), userInfo: nil, repeats: false);

                //HPがゼロ
            }
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: false);          phase = 1
            let level:Int = 10
            self.HP.text = "HP:" + String(player.HP!*level) + "/" + String(level*5)
            
            
            break
        default:
            str = "あいこです"
            self.gametext.text = str
            btnno()
            
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: false)
            phase = 1
            
            break
        }
        
        }
    }
    func onUpdate(timer: NSTimer) {
        self.gametext.text = "好きな手を入れて下さい"
        btnyes()
    }
    
    func returnv(timer: NSTimer) {
       
       app.player = player
        app.enemy = enemy
        app.quest = quest
        app.flag = true
        
        self.dismissViewControllerAnimated(true, completion: nil)
        

    }
    func setenemyhand(dset: UInt32){
        if dset == 1{
            enemyhand.image = UIImage(named: "gu-")
            
        }
        else if dset == 2 {
            
            enemyhand.image = UIImage(named: "choki")
        }
        else if dset == 3 {
            
            enemyhand.image = UIImage(named: "pa-")
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
    
    
    
    
    func start(){
        let n:Int = 1
        NSThread.sleepForTimeInterval(1.0)
        self.gametext.text = "好きな手を入れて下さい"
        
        gu.enabled = true
        choki.enabled = true
        pa.enabled = true
        phase = 1
        
        /*
        while n != 0 {
        
        switch phase {
        case 0:
        sleep(1)
        
        
        break
        
        case 1:
        
        break
        
        
        
        default:
        break
        }
        
        
        
        
        
        
        
        
        
        
        
        }
        */
    }
    
    deinit {
        print("jyankenViewController")
    }
    
   }

