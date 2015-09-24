//
//  ViewController.swift
//  literacy_2015ogaki
//
//  Created by Nishinaka Tomoki on 2015/09/14.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit

var level = 45

class ViewController: UIViewController {
    
    @IBOutlet weak var levelView: UILabel!
    @IBOutlet weak var nameView: UILabel!
    
    @IBOutlet weak var weaponName: UILabel!
    @IBOutlet weak var armorName: UILabel!
    
    @IBOutlet weak var map: mapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //test
        self.levelView.text = String(level)
        self.nameView.text = "T.Kosen"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mainLeftButtonAction(sender: AnyObject) {
    }
    
    @IBAction func mainRightButtonAction(sender: AnyObject) {
    }
}

