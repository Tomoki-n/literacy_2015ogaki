//
//  EnemyViewController.swift
//  literacy_2015ogaki
//
//  Created by 山口将槻 on 2015/10/08.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit

class EnemyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(sender: AnyObject) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.flag = true
        appDelegate.win = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
