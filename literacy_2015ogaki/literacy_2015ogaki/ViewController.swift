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
    
    var recent:CLBeacon?
    var b_count = 0
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //test
        self.levelView.text = String(self.level)
        self.nameView.text = "T.Kosen"
        
        self.myUUID = NSUUID(UUIDString: "00000000-88F6-1001-B000-001C4D2D20E6")
        self.myRegion = CLBeaconRegion(proximityUUID: self.myUUID, identifier: self.myUUID.UUIDString)
        self.locationManerger = CLLocationManager()
        self.locationManerger.delegate? = self
        
        self.locationManerger.startMonitoringForRegion(self.myRegion!)
        self.map.drawBeacons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func questButton(sender: AnyObject) {
        self.performSegueWithIdentifier("quest", sender: self)
    }
    
    //iBeacon関連の関数
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("iPad did Enter Region")
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("iPad did Exit Region")
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let closeBeacon = beacons.first as! CLBeacon
        //最初の処理
        if self.recent == nil && closeBeacon.accuracy < 1.0 {
            self.recent = closeBeacon
        }
        
        //最近通ったビーコンの更新、雑魚とのエンカウント
        if self.recent != closeBeacon && closeBeacon.accuracy < 1.0 {
            self.b_count++
            self.recent = closeBeacon
            if self.b_count >= 3 {
                self.b_count = 0
                var uiAlert = UIAlertController(title: "敵が現れた！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                uiAlert.addAction(UIAlertAction(title: "たたかう", style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction!) -> Void in
                    self.performSegueWithIdentifier("enemy", sender: self)
                }))
                presentViewController(uiAlert, animated: true, completion: nil)
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
        }
    }
}

