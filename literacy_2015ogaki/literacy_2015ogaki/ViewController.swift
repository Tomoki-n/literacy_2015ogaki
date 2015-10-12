//
//  ViewController.swift
//  literacy_2015ogaki
//
//  Created by Nishinaka Tomoki on 2015/09/14.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var levelView: UILabel!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var HPView: UILabel!
    
    @IBOutlet weak var weaponName: UILabel!
    @IBOutlet weak var armorName: UILabel!
    
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
    @IBOutlet weak var hilightedBeacon: UIImageView!
    
    
    var locationManerger:CLLocationManager!
    var myUUID:NSUUID!
    var selectUUID:NSUUID!
    var myRegion:CLBeaconRegion!
    var selectBeacon:CLBeacon!
    
    var id = 0
    var b_count = 0
    var level = 1
    var death = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //test
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.levelView.text = String(self.level)
        self.nameView.text = appDelegate.player.name
        appDelegate.player.HP = 4
        self.HPView.text = String(appDelegate.player.HP! * level * 10)
        self.hilightedBeacon.frame.origin = CGPointMake(-1000, -1000)
        
        UIView.animateWithDuration(NSTimeInterval(1.0), delay: 0.0, options: UIViewAnimationOptions.Repeat, animations: { () -> Void in
            if self.hilightedBeacon.alpha >= 0.5 {
                self.hilightedBeacon.alpha = 0.3
            }else{
                self.hilightedBeacon.alpha = 1.0
            }
        }, completion: nil)
        
        self.myUUID = NSUUID(UUIDString: "00000000-88F6-1001-B000-001C4D2D20E6")
        self.myRegion = CLBeaconRegion(proximityUUID: self.myUUID, identifier: self.myUUID.UUIDString)
        self.locationManerger = CLLocationManager()
        self.locationManerger.delegate = self
        self.locationManerger.requestWhenInUseAuthorization()
    }
    
    override func viewDidAppear(animated: Bool) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        println(appDelegate.win)
        if appDelegate.flag && appDelegate.win {
            self.level += 3
            self.levelView.text = String(self.level)
            !appDelegate.flag
        }else if appDelegate.flag && !appDelegate.win {
            self.death = true
            self.map.image = UIImage(named: "Grassland_Gray.png")
            !appDelegate.flag
        }
        self.HPView.text = String(appDelegate.player.HP! * self.level * 10)
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
            println("許可がありません")
            break
        }
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("iPad did Enter Region")
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("iPad did Exit Region")
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        //フラグ類
        var recoveryFlag = false
        
        if beacons.count != 0 {
            let closeBeacon = beacons.first as! CLBeacon
            println(closeBeacon)
            let newid = closeBeacon.major.integerValue * 5 + closeBeacon.minor.integerValue
            drawEffectonBeacon(newid)
            if self.id != newid && closeBeacon.proximity == CLProximity.Immediate {
                self.id = newid
                println(self.id)
                //回復
                if appDelegate.player.HP < 5 && id == 8 {
                    var recovery = UIAlertController(title: "体力が回復した！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    recovery.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                        appDelegate.player.HP? = 5
                        self.HPView.text = String(appDelegate.player.HP! * self.level * 10)
                    }))
                    self.presentViewController(recovery, animated: true, completion: nil)
                    if self.death {
                        self.death = false
                        self.map.image = UIImage(named: "Grassland.png")
                    }
                    recoveryFlag = true
                }
        
                //エンカウント
                if !self.death {
                    self.level++
                    self.levelView.text = String(self.level)
                    self.HPView.text = String(appDelegate.player.HP! * self.level * 10)
                    self.b_count++
                }
                
                if !recoveryFlag && !self.death {
                    if self.b_count >= 3 {
                        var enemy = UIAlertController(title: "敵が現れた！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                        enemy.addAction(UIAlertAction(title: "たたかう", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                            self.performSegueWithIdentifier("enemy", sender: self)
                        }))
                        self.presentViewController(enemy, animated: true, completion: nil)
                        self.b_count = 0
                    }
                }else{
                    if self.b_count >= 3 {
                        self.b_count--
                    }
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "enemy" {
            //enemyViewに渡す値の設定
            var eVC = segue.destinationViewController as! UIViewController
        }else if segue.identifier == "boss" {
            //bossViewに渡す値の設定
            var bVC = segue.destinationViewController as! UIViewController
        }else if segue.identifier == "quest" {
            var qVC = segue.destinationViewController as! questViewController
            qVC.items = [true, true, true]
            qVC.level = self.level
            qVC.name = self.nameView.text
        }
    }
    
    func drawEffectonBeacon(id: Int){
        switch id {
        case 1:
            self.hilightedBeacon.frame.origin.x = self.beacon1.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon1.frame.origin.y
            break
        case 2:
            self.hilightedBeacon.frame.origin.x = self.beacon2.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon2.frame.origin.y
            break
        case 3:
            self.hilightedBeacon.frame.origin.x = self.beacon3.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon3.frame.origin.y
            break
        case 4:
            self.hilightedBeacon.frame.origin.x = self.beacon4.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon4.frame.origin.y
            break
        case 5:
            self.hilightedBeacon.frame.origin.x = self.beacon5.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon5.frame.origin.y
            break
        case 6:
            self.hilightedBeacon.frame.origin.x = self.beacon6.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon6.frame.origin.y
            break
        case 7:
            self.hilightedBeacon.frame.origin.x = self.beacon7.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon7.frame.origin.y
            break
        case 8:
            self.hilightedBeacon.frame.origin.x = self.beacon8.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon8.frame.origin.y
            break
        case 9:
            self.hilightedBeacon.frame.origin.x = self.beacon9.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon9.frame.origin.y
            break
        case 10:
            self.hilightedBeacon.frame.origin.x = self.beacon10.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon10.frame.origin.y
            break
        case 11:
            self.hilightedBeacon.frame.origin.x = self.beacon11.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon11.frame.origin.y
            break
        case 12:
            self.hilightedBeacon.frame.origin.x = self.beacon12.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon12.frame.origin.y
            break
        case 13:
            self.hilightedBeacon.frame.origin.x = self.beacon13.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon13.frame.origin.y
            break
        case 14:
            self.hilightedBeacon.frame.origin.x = self.beacon14.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon14.frame.origin.y
            break
        case 15:
            self.hilightedBeacon.frame.origin.x = self.beacon15.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon15.frame.origin.y
            break
        case 16:
            self.hilightedBeacon.frame.origin.x = self.beacon16.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon16.frame.origin.y
            break
        case 17:
            self.hilightedBeacon.frame.origin.x = self.beacon17.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon17.frame.origin.y
            break
        case 18:
            self.hilightedBeacon.frame.origin.x = self.beacon18.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon18.frame.origin.y
            break
        case 19:
            self.hilightedBeacon.frame.origin.x = self.beacon19.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon19.frame.origin.y
            break
        case 20:
            self.hilightedBeacon.frame.origin.x = self.beacon20.frame.origin.x
            self.hilightedBeacon.frame.origin.y = self.beacon20.frame.origin.y
            break
        default :
            break
        }
    }
    
    @IBAction func boss(sender: AnyObject) {
        self.performSegueWithIdentifier("boss", sender: self)
    }
}

