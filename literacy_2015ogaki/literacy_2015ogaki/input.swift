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
            
                let NVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("tes")
                self.presentViewController(NVC, animated: true, completion: nil)
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
}

class kagiViewController:UIViewController {

    
    
    @IBAction func re(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}

class storyViewController:UIViewController {
    
    
    @IBOutlet var gametext: UITextView!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewWillAppear(animated: Bool) {
            
        switch appDelegate.map {
        case 0:
            gametext.text = "草原のボス＜黒猫ヤマト＞を倒した勇者は、さらなる強さを求めて海岸へ向かいました。勇者は最後に”双鯨デル＆トラ”と呼ばれる二頭のクジラがいます。風を操る“デル”は背中から強力な突風を発生させ、勇者を吹き飛ばそうとします。敵と戦いながら海岸にあるいくつかの海にまつわるアイテムを集めてより強い装備を作り上げ、ボスに挑むのでした。"
            break
        case 1:
            gametext.text = "海岸のボス＜双鯨デル＆トラ＞を倒した勇者は、次の敵を倒すため森林へと向かいました。暗い森林にはどこに恐ろしい敵が潜んでいるかわかりません。森林には海岸よりたくさんのアイテムあります。アイテム全て集め、より強い装備で敵に挑んでいくのでした。"
            break
        case 2:
            gametext.text = "森林のボス＜孤狼ウルヴァ＞を倒した勇者は、次の敵を倒すため砂漠へと向かいました。砂漠には好戦的で戦闘的な敵がたくさんいます。アイテムの一つ「星の砂」は過去にやってきた勇者が敵に体内の水分を奪い取られて残った残骸です。敵に水分を奪い取られ、「星の砂」になってしまわないように、アイテムを集めて敵を倒しにいくのでした。"
            break
        case 3:
            gametext.text = "これまでに4ステージのボスを倒した勇者は、お姫様をさらった大魔王が住む魔界へと向かいました。これまでの4ステージでの思い出、さらに2つのアイテムをゲットしよう。アイテムの一つ「壊れたあいぱっど」は過去に大魔王に倒された勇者が持っていたもので、勇者を倒す強い思いが入っています。きっと壊れたあいぱっどが勇者を勝利に導いてくれるでしょう。"
            break
        
        default :
            break
        
        }
        
        
    }
    
    
    
    
    @IBAction func re(sender: AnyObject) {
        self.performSegueWithIdentifier("main", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "main" {
            var mVC = segue.destinationViewController as! ViewController
        }
    }
    
}