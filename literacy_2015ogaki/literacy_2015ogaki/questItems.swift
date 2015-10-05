//
//  questItems.swift
//  literacy_2015ogaki
//
//  Created by 山口将槻 on 2015/10/05.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit

class questItems: UIImageView {
    
    func setItemImages(item: [Bool]){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        for var i = 0; i < item.count; i++ {
            if item[i] {
                var getItem = UIImageView(image: UIImage(named: "getItem.png"))
                switch i {
                case 0:
                    getItem.frame = CGRectMake(50, 280, 150, 150)
                    self.addSubview(getItem)
                    break
                case 1:
                    getItem.frame = CGRectMake(290, 280, 150, 150)
                    self.addSubview(getItem)
                    break
                case 2:
                    getItem.frame = CGRectMake(530, 280, 150, 150)
                    self.addSubview(getItem)
                    break
                default:
                    break
                }
            }
        }
    }
}
