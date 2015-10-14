//
//  input.swift
//  literacy_2015ogaki
//
//  Created by Nishinaka Tomoki on 2015/10/14.
//  Copyright © 2015年 Nishinaka Tomoki. All rights reserved.
//

import Foundation
import UIKit

class inputViewController:UIViewController {
    
    @IBOutlet var text: UITextView!
        
    @IBOutlet var test1: UIButton!
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func test2(sender: AnyObject) {
        if text.text != ""{
        app.player.name! = text.text!
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
}