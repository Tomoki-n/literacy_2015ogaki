//
//  questViewController.swift
//  literacy_2015ogaki
//
//  Created by 山口将槻 on 2015/10/05.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit

class questViewController: UIViewController {

    @IBOutlet weak var itemView: questItems!
    @IBOutlet weak var levelView: UILabel!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var weaponView: UILabel!
    @IBOutlet weak var armorView: UILabel!
    
    var level:Int?
    var name:String?
    
    var items:Array<Bool>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDeleagte = UIApplication.sharedApplication().delegate as! AppDelegate
        self.itemView.setItemImages(items!)
        self.nameView.text = appDeleagte.player.name
        self.levelView.text = String(self.level!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mapButton(sender: AnyObject) {
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
