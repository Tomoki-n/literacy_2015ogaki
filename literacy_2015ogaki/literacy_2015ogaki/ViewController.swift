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
    
    @IBOutlet var beacons:Array<CLBeacon> = []
    @IBOutlet weak var locationManerger:CLLocationManager!
    @IBOutlet weak var myUUID:NSUUID!
    @IBOutlet weak var selectUUID:NSUUID!
    @IBOutlet weak var myRegion:CLBeaconRegion!
    @IBOutlet weak var selectBeacon:CLBeacon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //test
        self.levelView.text = String(level)
        self.nameView.text = "T.Kosen"
        
        self.myUUID? = NSUUID().
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
    
}

