//
//  ViewController.swift
//  literacy_2015ogaki
//
//  Created by Nishinaka Tomoki on 2015/09/14.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var levelView: UILabel!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var HPView: UILabel!
    
    @IBOutlet weak var weaponName: UILabel!
    @IBOutlet weak var armorName: UILabel!
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var armorImage: UIImageView!
    
    @IBOutlet weak var map: UIImageView!
    //beacons
    @IBOutlet weak var beacon1: UIImageView!
    @IBOutlet weak var beacon2: UIImageView!
    @IBOutlet weak var beacon3: UIImageView!
    @IBOutlet weak var beacon4: UIImageView!
    @IBOutlet weak var beacon5: UIImageView!
    @IBOutlet weak var beacon6: UIImageView!
    @IBOutlet weak var beacon7: UIImageView!
    @IBOutlet weak var beacon8: UIImageView!
    @IBOutlet weak var beacon9: UIImageView!
    @IBOutlet weak var beacon10: UIImageView!
    @IBOutlet weak var beacon11: UIImageView!
    @IBOutlet weak var beacon12: UIImageView!
    @IBOutlet weak var beacon13: UIImageView!
    @IBOutlet weak var beacon14: UIImageView!
    @IBOutlet weak var beacon15: UIImageView!
    @IBOutlet weak var beacon16: UIImageView!
    @IBOutlet weak var beacon17: UIImageView!
    @IBOutlet weak var beacon18: UIImageView!
    @IBOutlet weak var beacon19: UIImageView!
    @IBOutlet weak var beacon20: UIImageView!
    @IBOutlet var zuru: UILabel!
    
    
    var locationManerger:CLLocationManager!
    var myUUID:NSUUID!
    var selectUUID:NSUUID!
    var myRegion:CLBeaconRegion!
    var selectBeacon:CLBeacon!
    
    var id = 0
    var before_id = 0
    var b_count = 0
    
    var bgm = Sound()
    var bgm1 = Sound()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //test
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        print(String(appDelegate.player.level!) + "\n")
        appDelegate.quest.setNextQuest()
        self.levelView.text = String(appDelegate.player.level!)
        self.nameView.text = appDelegate.player.name
        self.HPView.text = String(appDelegate.player.HP! * appDelegate.player.level! * 10)
        print(appDelegate.player.level)
        
        self.myUUID = NSUUID(UUIDString: "00000000-88F6-1001-B000-001C4D2D20E6")
        self.myRegion = CLBeaconRegion(proximityUUID: self.myUUID, identifier: self.myUUID.UUIDString)
        self.locationManerger = CLLocationManager()
        self.locationManerger.delegate = self
        self.locationManerger.requestWhenInUseAuthorization()
    }
    
    override func viewDidAppear(animated: Bool) {
       
        self.locationManerger.startRangingBeaconsInRegion(self.myRegion)
        setmusic()
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        self.zuru.text = String(appDelegate.quest.item1Position!) + String(appDelegate.quest.item2Position!) + String(appDelegate.quest.item3Position!)
      
        self.weaponName.text = appDelegate.player.weapon
        self.weaponImage.image = UIImage(named: appDelegate.player.weaponImage!)
        self.armorName.text = appDelegate.player.armor
        self.armorImage.image = UIImage(named: appDelegate.player.armorImage!)
        print(appDelegate.player.HP!)
        if appDelegate.flag && appDelegate.player.HP != 0 {
            if appDelegate.quest.getMapQuestFinished() && appDelegate.boss {
                appDelegate.player.level! += 5
                self.levelView.text = String(appDelegate.player.level!)
                appDelegate.itemFlag = false
                drawBeacon(appDelegate.enemy.getBossPosition(), image: "ringBlue.png")
                appDelegate.map++
                appDelegate.quest.setNextQuest()
                switch appDelegate.map {
                case 1:
                    self.map.image = UIImage(named: "Coast.png")
                    break
                case 2:
                    self.map.image = UIImage(named: "Forest.png")
                    break
                case 3:
                    self.map.image = UIImage(named: "Desert.png")
                    break
                case 4:
                    self.map.image = UIImage(named: "Devil.png")
                    break
                default:
                    break
                }
                var mapAlert =  UIAlertController(title:"次のマップに移動します", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                mapAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                if appDelegate.map >= 5 {
                    var alert =  UIAlertController(title:"おしまい", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }else{
                    self.presentViewController(mapAlert, animated: true, completion: nil)
                }
            }else if appDelegate.flag{
                appDelegate.player.level! += 3
                self.levelView.text = String(appDelegate.player.level!)
            }
            appDelegate.flag = false
            appDelegate.boss = false
        }else if appDelegate.flag && appDelegate.player.HP == 0 {
            print("死んだ")
            self.map.image = UIImage(named: appDelegate.quest.getGrayMap())
            !appDelegate.flag
        }
        self.HPView.text = String(appDelegate.player.HP! * appDelegate.player.level! * 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func questButton(sender: AnyObject) {
        self.performSegueWithIdentifier("quest", sender: self)
    }
    
    //iBeacon関連の関数
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedWhenInUse:
            self.locationManerger.startRangingBeaconsInRegion(self.myRegion)
            break
        default:
            print("許可がありません\n")
            break
        }
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("iPad did Enter Region")
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("iPad did Exit Region")
    }
    func setmusic(){
        switch app.map {
        
        case 0:
            
            bgm.ids(9)
            bgm.infstart()
            break
            
        case 1:
            
            bgm.ids(6)
            bgm.infstart()
            break
            
        case 2:
            
            bgm.ids(7)
            bgm.infstart()
            break
            
        case 3:
            
            bgm.ids(8)
            bgm.infstart()
            break
            
        case 4:
            
            bgm.ids(16)
            bgm.infstart()
            break
        default:
            break
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        //フラグ
        var bossFlag = false
        var item = false
        
        if beacons.count != 0 {
            let closeBeacon = beacons.first as CLBeacon?
            let newid = closeBeacon!.major.integerValue * 5 + closeBeacon!.minor.integerValue
            if self.id != newid && closeBeacon!.proximity == CLProximity.Immediate {
                self.id = newid
                if appDelegate.quest.item1Position == self.id {
                    item = true
                }else if appDelegate.quest.item2Position == self.id {
                    item = true
                }else if appDelegate.quest.item3Position == self.id {
                    item = true
                }
                drawEffectonBeacon(self.id)
              
                if self.id == 8 && appDelegate.player.HP != 5{
                    //回復
                    var recovery = UIAlertController(title: "体力が回復した！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    recovery.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                        self.bgm1.ids(10)
                        self.bgm1.start()
                        appDelegate.player.HP? = 5
                        self.HPView.text = String(appDelegate.player.HP! * appDelegate.player.level! * 10)
                        if self.death {
                            self.death = false
                            switch appDelegate.map {
                            case 0:
                                self.map.image = UIImage(named: "Grassland.png")
                            case 1:
                                self.map.image = UIImage(named: "Coast.png")
                                break
                            case 2:
                                self.map.image = UIImage(named: "Forest.png")
                                break
                            case 3:
                                self.map.image = UIImage(named: "Desert.png")
                                break
                            case 4:
                                self.map.image = UIImage(named: "Devil.png")
                                break
                            default:
                                break
                            }
                        }
                    }))
                    self.presentViewController(recovery, animated: true, completion: nil)
                }else if bossFlag && self.id == appDelegate.enemy.getBossPosition() && appDelegate.player.HP != 0 {
                    //ボス
                    var alert = UIAlertController(title: "強敵が現れた！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "たたかう", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction!) -> Void in
                        self.performSegueWithIdentifier("boss", sender: self)
                    }))
                    bossFlag = true

                }else if !bossFlag && appDelegate.quest.getMapQuestFinished() && appDelegate.player.level >= appDelegate.map * 30 {
                    //ボス表示
                    var alert = UIAlertController(title: "強敵が現れた！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.Default, handler: nil))
                    bossFlag = true
                    presentViewController(alert, animated: true, completion: nil)
                    drawBeacon(appDelegate.enemy.getBossPosition(), image: "boss.png")
                }else if !appDelegate.quest.getMapQuestFinished() && appDelegate.player.HP != 0 && item {
                    //アイテム
                    var items:UIAlertController
                    if appDelegate.quest.item1Position == self.id && appDelegate.quest.getItemStatus()[0] == false {
                        items = UIAlertController(title: appDelegate.quest.item1! + "を手に入れた！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                        items.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                            self.performSegueWithIdentifier("quest", sender: self)
                        }))
                        appDelegate.quest.getItem(1)
                        self.presentViewController(items, animated: true, completion: nil)
                    }else if appDelegate.quest.item2Position == self.id && appDelegate.quest.getItemStatus()[1] == false {
                        items = UIAlertController(title: appDelegate.quest.item2! + "を手に入れた！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                        items.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                            self.performSegueWithIdentifier("quest", sender: self)
                        }))
                        appDelegate.quest.getItem(2)
                        self.presentViewController(items, animated: true, completion: nil)
                    }else if appDelegate.quest.item3Position == self.id && appDelegate.quest.getItemStatus()[2] == false {
                        items = UIAlertController(title: appDelegate.quest.item3! + "を手に入れた！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                        items.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                            self.performSegueWithIdentifier("quest", sender: self)
                        }))
                        appDelegate.quest.getItem(3)
                        self.presentViewController(items, animated: true, completion: nil)
                    }
                }else if appDelegate.player.HP != 0 && self.id != 8 {
                    self.b_count++
                    if self.b_count >= 3 {
                        self.b_count = 0
                        var enemy = UIAlertController(title: "敵が現れた！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                        enemy.addAction(UIAlertAction(title: "たたかう", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                            self.performSegueWithIdentifier("enemy", sender: self)
                        }))
                        self.presentViewController(enemy, animated: true, completion: nil)
                    }else{
                        appDelegate.player.level!++
                        self.levelView.text = String(appDelegate.player.level!)
                        self.HPView.text = String(appDelegate.player.HP! * appDelegate.player.level! * 10)
                    }
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.locationManerger.stopRangingBeaconsInRegion(self.myRegion)
        
        if segue.identifier == "enemy" {
            //enemyViewに渡す値の設定
            bgm.ids(15)
            bgm.start()
            var eVC = segue.destinationViewController as! jyankenViewController
        }else if segue.identifier == "boss" {
            bgm.ids(15)
            bgm.start()
            //bossViewに渡す値の設定
            var bVC = segue.destinationViewController as! BossViewController
            var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.boss = true
        }else if segue.identifier == "quest" {
            var qVC = segue.destinationViewController as! questViewController
        }
    }
    
    
    func drawEffectonBeacon(id :Int){
        let image = UIImage(named: "ringYellow")
        switch self.id {
        case 1:
            self.beacon1.image = image
            break
        case 2:
            self.beacon2.image = image
            break
        case 3:
            self.beacon3.image = image
            break
        case 4:
            self.beacon4.image = image
            break
        case 5:
            self.beacon5.image = image
            break
        case 6:
            self.beacon6.image = image
            break
        case 7:
            self.beacon7.image = image
            break
        case 8:
            self.beacon8.image = image
            break
        case 9:
            self.beacon9.image = image
            break
        case 10:
            self.beacon10.image = image
            break
        case 11:
            self.beacon11.image = image
            break
        case 12:
            self.beacon12.image = image
            break
        case 13:
            self.beacon13.image = image
            break
        case 14:
            self.beacon14.image = image
            break
        case 15:
            self.beacon15.image = image
            break
        case 16:
            self.beacon16.image = image
            break
        case 17:
            self.beacon17.image = image
            break
        case 18:
            self.beacon18.image = image
            break
        case 19:
            self.beacon19.image = image
            break
        case 20:
            self.beacon20.image = image
            break
        default:
            break
        }
        
        let blue = UIImage(named: "ringBlue.png")
        switch self.before_id {
        case 1:
            self.beacon1.image = blue
            break
        case 2:
            self.beacon2.image = blue
            break
        case 3:
            self.beacon3.image = blue
            break
        case 4:
            self.beacon4.image = blue
            break
        case 5:
            self.beacon5.image = blue
            break
        case 6:
            self.beacon6.image = blue
            break
        case 7:
            self.beacon7.image = blue
            break
        case 8:
            self.beacon8.image = UIImage(named: "recoveryPoint.png")
            break
        case 9:
            self.beacon9.image = blue
            break
        case 10:
            self.beacon10.image = blue
            break
        case 11:
            self.beacon11.image = blue
            break
        case 12:
            self.beacon12.image = blue
            break
        case 13:
            self.beacon13.image = blue
            break
        case 14:
            self.beacon14.image = blue
            break
        case 15:
            self.beacon15.image = blue
            break
        case 16:
            self.beacon16.image = blue
            break
        case 17:
            self.beacon17.image = blue
            break
        case 18:
            self.beacon18.image = blue
            break
        case 19:
            self.beacon19.image = blue
            break
        case 20:
            self.beacon20.image = blue
            break
        default:
            break
            
        }
        self.before_id = id
    }
    
    func drawBeacon(id:Int, image:String){
        let image = UIImage(named: image)
        switch id {
        case 1:
            self.beacon1.image = image
            break
        case 2:
            self.beacon2.image = image
            break
        case 3:
            self.beacon3.image = image
            break
        case 4:
            self.beacon4.image = image
            break
        case 5:
            self.beacon5.image = image
            break
        case 6:
            self.beacon6.image = image
            break
        case 7:
            self.beacon7.image = image
            break
        case 8:
            self.beacon8.image = image
            break
        case 9:
            self.beacon9.image = image
            break
        case 10:
            self.beacon10.image = image
            break
        case 11:
            self.beacon11.image = image
            break
        case 12:
            self.beacon12.image = image
            break
        case 13:
            self.beacon13.image = image
            break
        case 14:
            self.beacon14.image = image
            break
        case 15:
            self.beacon15.image = image
            break
        case 16:
            self.beacon16.image = image
            break
        case 17:
            self.beacon17.image = image
            break
        case 18:
            self.beacon18.image = image
            break
        case 19:
            self.beacon19.image = image
            break
        case 20:
            self.beacon20.image = image
            break
        default:
            break
        }

    }
    
    func refreshItemPosition(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let items = appDelegate.quest.getItemStatus()
        if appDelegate.quest.getQuestItemCounts() == 2 {
            
        }
    }
    
    @IBAction func boss(sender: AnyObject) {
        self.performSegueWithIdentifier("boss", sender: self)
    }
}

