//
//  select.swift
//  literacy_2015ogaki
//
//  Created by Nishinaka Tomoki on 2015/10/10.
//  Copyright © 2015年 Nishinaka Tomoki. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class selectViewController: UIViewController {
    
    //Appdelegate
    var app:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    let bgm = Sound()

    
    @IBOutlet var fieldv: UILabel!
    
    @IBOutlet var bossv: UILabel!
    
    var fieldvv:Int = 0
    var bossvv:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fieldv.text = String(fieldvv)
        bossv.text = String(bossvv)
        bgm.ids(11)
        //bgm.para! = 0
        bgm.start()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func audioplay(field:Int){
        
    
        
    }
    
    @IBAction func field(sender: AnyObject) {
        
        if fieldvv == 4{
            fieldvv = -1
        }
        fieldvv++
        fieldv.text = String(fieldvv)
        bgm.ids(<#T##id: Int##Int#>)
    
        
        
    }
    
    
    @IBAction func setboss(sender: AnyObject) {
        
        if bossvv == 1{
            bossvv = -1
        }
        bossvv++
        bossv.text = String(bossvv)
        
        
        
    }
   
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        let audioPath = NSBundle.mainBundle().pathForResource("battle", ofType: "mp3")!
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        return audioPlayer!
    }
    
    @IBAction func battle(sender: AnyObject) {
        app.player.HP = 5
        app.player.level = 50
        app.map = fieldvv
        
        if bossvv == 1{
            let NVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("boss") 
            self.presentViewController(NVC, animated: true, completion: nil)
        }else{
            let NVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ja") 
            self.presentViewController(NVC, animated: true, completion: nil)
            
            
        }
        
        
        
    }
    
}

