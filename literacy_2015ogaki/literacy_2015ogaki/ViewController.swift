//
//  ViewController.swift
//  literacy_2015ogaki
//
//  Created by Nishinaka Tomoki on 2015/09/14.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIToolbarDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var bossButton: UIButton!
    @IBOutlet weak var charaImage: UIImageView!
    
    
    @IBOutlet weak var name1Label: UILabel!
    @IBOutlet weak var name2Label: UILabel!
    @IBOutlet weak var name3Label: UILabel!
    @IBOutlet weak var image1Label: UILabel!
    @IBOutlet weak var image2Label: UILabel!
    @IBOutlet weak var image3Label: UILabel!
    
    //Appdelegate
    var app:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    //画像
    var enemyImage:UIImage!
    //エリア選択
    var areaArray:NSArray = ["草原","海岸","森林","砂浜","魔界"]
    var myToolBar:UIToolbar!
    var myPickerView:UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        //敵表示
        enemyImage = UIImage(named:app.enemy.Image!)
        charaImage.image = enemyImage
        self.view.addSubview(charaImage)
        
        name1Label.text = app.enemy.Name!
        image1Label.text = app.enemy.Image!
        
        //エリア選択
        myPickerView = UIPickerView()
        myPickerView.showsSelectionIndicator = true
        myPickerView.delegate = self
        //myPickerView.selectRow(1, inComponent: 0, animated: false);
        textField.placeholder = areaArray[0] as? String;
        self.view.addSubview(textField)
        myToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        myToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        myToolBar.backgroundColor = UIColor.blackColor()
        myToolBar.barStyle = UIBarStyle.Black
        myToolBar.tintColor = UIColor.whiteColor()
        let myToolBarButton = UIBarButtonItem(title: "Close", style: .Bordered, target: self, action: "onClick:")
        myToolBarButton.tag = 1
        myToolBar.items = [myToolBarButton]
        textField.inputView = myPickerView
        textField.inputAccessoryView = myToolBar
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getEnemy(sender: UIButton) {
        //敵セット
        app.enemy.setEnemy()
        //描画し直し
        enemyImage = UIImage(named:app.quest.armorImage!)
        charaImage.image = enemyImage
        self.view.addSubview(charaImage)
        
        name1Label.text  = app.player.weapon
        image1Label.text = app.player.armor
        name2Label.text  = app.quest.weapon
        image2Label.text = app.quest.armor
        name3Label.text  = app.quest.item3
        var x:String = String(stringInterpolationSegment: app.quest.getQuestFinished())
        image3Label.text = x
        print(app.quest.getItemStatus())
        app.quest.getItem(1)
        println(app.quest.getItemStatus())
    }

    
    @IBAction func getBossEnemy(sender: AnyObject) {
        //ボス敵セット
        app.enemy.setBoss()
        //描画し直し
        name1Label.text = app.enemy.Name!
        image1Label.text = app.enemy.Image!
        enemyImage = UIImage(named:app.quest.getGrayMap())
        charaImage.image = enemyImage
        self.view.addSubview(charaImage)
        
        app.quest.setNextQuest()
        app.player.setNextWeapon()
        app.player.setNextArmor()
        
    }
 
    //以下選択バーの処理
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return areaArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return areaArray[row] as? String;
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = areaArray[row] as? String;
        //選択したエリアでapp.map変更
        switch(row){
        case 0:
            app.map = 0
            break
        case 1:
            app.map = 1
            break
        case 2:
            app.map = 2
            break
        case 3:
            app.map = 3
            break
        case 4:
            app.map = 4
            break
        default:
            break
        }
    }
    
    //閉じる
    func onClick(sender: UIBarButtonItem) {
        textField.resignFirstResponder()
    }
}

