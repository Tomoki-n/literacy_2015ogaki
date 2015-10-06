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
    
    @IBOutlet weak var weaponName: UILabel!
    @IBOutlet weak var armorName: UILabel!
    
    @IBOutlet weak var map: mapView!
    
    var locationManerger:CLLocationManager!
    var myUUID:NSUUID!
    var selectUUID:NSUUID!
    var myRegion:CLBeaconRegion!
    var selectBeacon:CLBeacon!
    
    var id = 0
    var b_count = 0
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //test
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.levelView.text = String(self.level)
        self.nameView.text = appDelegate.player.name
        appDelegate.player.HP = 4
        
        self.myUUID = NSUUID(UUIDString: "00000000-88F6-1001-B000-001C4D2D20E6")
        self.myRegion = CLBeaconRegion(proximityUUID: self.myUUID, identifier: self.myUUID.UUIDString)
        self.locationManerger = CLLocationManager()
        self.locationManerger.delegate = self
        self.locationManerger.requestWhenInUseAuthorization()
        self.map.drawBeacons()
        println("View was Loaded")
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
        
        if beacons.count != 0 {
            let closeBeacon = beacons.first as! CLBeacon
            let newid = closeBeacon.major.integerValue * 5 + closeBeacon.minor.integerValue
            println(newid)
            if self.id != newid && closeBeacon.proximity == CLProximity.Immediate {
                self.id = newid
                self.map.drawEffectonBeacon(id) //対応したbeaconの青丸が黄色になる
        
                //回復
                if appDelegate.player.HP < 5 && id == 8 {
                    var recovery = UIAlertController(title: "体力が回復した！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    recovery.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                        appDelegate.player.HP? = 5
                    }))
                    self.presentViewController(recovery, animated: true, completion: nil)
                }
        
                //エンカウント
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "enemy" {
            //enemyViewに渡す値の設定
        }else if segue.identifier == "boss" {
            //bossViewに渡す値の設定
        }else if segue.identifier == "quest" {
            var qVC = segue.destinationViewController as! questViewController
            qVC.items = [true, true, true]
            qVC.level = self.level
            qVC.name = self.nameView.text
        }
    }
}

