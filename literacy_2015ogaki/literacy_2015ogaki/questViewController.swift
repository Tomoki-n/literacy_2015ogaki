//
//  questViewController.swift
//  literacy_2015ogaki
//
//  Created by 山口将槻 on 2015/10/05.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit

class questViewController: UIViewController {

    @IBOutlet weak var levelView: UILabel!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var weaponView: UILabel!
    @IBOutlet weak var armorView: UILabel!
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var armorImage: UIImageView!
    
    @IBOutlet weak var item1: UIImageView!
    @IBOutlet weak var item2: UIImageView!
    @IBOutlet weak var item3: UIImageView!
    
    var items:Array<Bool>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.nameView.text = appDelegate.player.name
        self.levelView.text = String(appDelegate.player.level!)
        self.weaponView.text = appDelegate.player.weapon
        self.weaponImage.image = UIImage(named: appDelegate.player.weaponImage!)
        self.armorView.text = appDelegate.player.armor
        self.armorImage.image = UIImage(named: appDelegate.player.armorImage!)
        
        self.item1.image = UIImage(named: appDelegate.quest.item1Image!)
        if appDelegate.quest.getQuestItemCounts() == 2 {
        self.item2.image = UIImage(named: appDelegate.quest.item2Image!)
        }else if appDelegate.quest.getQuestItemCounts() == 3 {
            self.item2.image = UIImage(named: appDelegate.quest.item2Image!)
            self.item3.image = UIImage(named: appDelegate.quest.item3Image!)
        }
    
        let questStatus = appDelegate.quest.getItemStatus()
        for var i = 0; i < appDelegate.quest.getQuestItemCounts(); i++ {
            if questStatus[i] {
                var get = UIImageView(image: UIImage(named: "getItem.png"))
                switch i {
                case 0:
                    get.frame = self.item1.frame
                    break
                case 1:
                    get.frame = self.item2.frame
                    break
                case 2:
                    get.frame = self.item3.frame
                    break
                default:
                    break
                }
                self.view.addSubview(get)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var questStatus = appDelegate.quest.getItemStatus()
        if questStatus == [true, true, true] && appDelegate.quest.getQuestFinished() && !appDelegate.itemFlag {
            if appDelegate.quest.getQuestEquip() == 1 {
                appDelegate.player.setNextWeapon()
                var weaponAlert = UIAlertController(title: "武器が" + appDelegate.player.weapon! + "になった！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                weaponAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(weaponAlert, animated: true, completion: nil)
            }else{
                appDelegate.player.setNextArmor()
                var alert = UIAlertController(title: "防具が" + appDelegate.player.armor! + "になった！", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
            }
            if !appDelegate.quest.getMapQuestFinished(){
                appDelegate.quest.setNextQuest()
            }else{
                appDelegate.itemFlag = true
            }
        }
        self.weaponView.text = appDelegate.player.weapon
        self.weaponImage.image = UIImage(named: appDelegate.player.weaponImage!)
        self.armorView.text = appDelegate.player.armor
        self.armorImage.image = UIImage(named: appDelegate.player.armorImage!)

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
