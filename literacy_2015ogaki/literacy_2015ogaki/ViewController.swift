//
//  ViewController.swift
//  literacy_2015ogaki
//
//  Created by Nishinaka Tomoki on 2015/09/14.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit
import CoreLocation

var level = 45

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var levelView: UILabel!
    @IBOutlet weak var nameView: UILabel!
    
    @IBOutlet weak var weaponName: UILabel!
    @IBOutlet weak var armorName: UILabel!
    
    @IBOutlet weak var map: mapView!
    
    @IBOutlet weak var locationManerger:CLLocationManager!
    @IBOutlet weak var myUUID:NSUUID!
    @IBOutlet weak var selectUUID:NSUUID!
    @IBOutlet weak var myRegion:CLBeaconRegion!
    @IBOutlet weak var selectBeacon:CLBeacon!
    
    @IBOutlet weak var recent: CLBeacon?
    var b_count: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //test
        self.levelView.text = String(level)
        self.nameView.text = "T.Kosen"
        
        
        self.myUUID? = NSUUID(UUIDString: "")!
        self.myRegion? = CLBeaconRegion(proximityUUID: self.myUUID, identifier: self.myUUID!.UUIDString)
        self.locationManerger? = CLLocationManager()
        self.locationManerger.delegate = self
        
        self.b_count! = 0
        
        self.locationManerger.startMonitoringForRegion(self.myRegion!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mainLeftButtonAction(sender: AnyObject) {
    }
    
    @IBAction func mainRightButtonAction(sender: AnyObject) {
    }
    
    //iBeacon関連の関数
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("iPad did Enter Region")
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        println("iPad did Exit Region")
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        //一番距離が近いbeaconをcloseBeaconに入れる
        var closeBeacon:CLBeacon = CLBeacon()
        
        for var i = 0; i < beacons.count; i++ {
            let beacon = beacons[i] as! CLBeacon
            
            if i == 0 {
                closeBeacon = beacon
            }else if closeBeacon.accuracy > beacon.accuracy{
                closeBeacon = beacon
            }
        }
        
        var b_pos:Int = closeBeacon.major!.integerValue * 5 + closeBeacon.minor!.integerValue
        
        if closeBeacon.major != recent?.major && closeBeacon.minor != recent?.minor {
            //closeBeaconの距離(accuracy)でアクション
            if closeBeacon.accuracy <= 1.0 {
                self.recent? = closeBeacon
                self.b_count!++
            }
            
            if 1 == 0/*指定レベル && クエスト完了 &&　beaconID一致*/ {
                self.performSegueWithIdentifier("boss", sender: self)
            }else if 1 == 0/*クエスト未完了*/ {
                //あとで
                if self.b_count! >= 3 {
                    self.b_count! = 0
                }
            }else if self.b_count! >= 3 {
                self.b_count! = 0
                //敵遭遇！
                var alert = UIAlertController(title: nil, message: "敵が現れた！！", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "たたかう", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
                    self.performSegueWithIdentifier("enemy", sender: self)
                }))
            }
        }
        
        //マップを光らせる処理
        self.map.drawLightEffect(b_pos)
    }
}

