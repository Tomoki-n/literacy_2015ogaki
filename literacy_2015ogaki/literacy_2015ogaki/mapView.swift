//
//  mapView.swift
//  literacy_2015ogaki
//
//  Created by 山口将槻 on 2015/09/24.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit

class mapView: UIImageView {
    
    var beacon1 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon2 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon3 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon4 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon5 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon6 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon7 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon8 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon9 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon10 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon11 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon12 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon13 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon14 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon15 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon16 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon17 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon18 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon19 = UIImageView(image: UIImage(named: "beacon(blue).png"))
    var beacon20 = UIImageView(image: UIImage(named: "beacon(blue).png"))

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    
    func drawBeacons(){
        let margin = (self.frame.width-140)/3
        self.beacon1.frame = CGRectMake(50, 70, 70, 70)
        self.beacon2.frame = CGRectMake(50+margin, 70, 70, 70)
        self.beacon3.frame = CGRectMake(50+margin*2, 70, 70, 70)
        self.beacon4.frame = CGRectMake(50+margin*3, 70, 70, 70)
        self.beacon5.frame = CGRectMake(50+margin*4, 70, 70, 70)
        self.beacon6.frame = CGRectMake(50, 210, 70, 70)
        self.beacon7.frame = CGRectMake(50+margin, 210, 70, 70)
        self.beacon8.frame = CGRectMake(50+margin*2, 210, 70, 70)
        self.beacon9.frame = CGRectMake(50+margin*3, 210, 70, 70)
        self.beacon10.frame = CGRectMake(50+margin*4, 210, 70, 70)
        self.beacon11.frame = CGRectMake(50, 350, 70, 70)
        self.beacon12.frame = CGRectMake(50+margin, 350, 70, 70)
        self.beacon13.frame = CGRectMake(50+margin*2, 350, 70, 70)
        self.beacon14.frame = CGRectMake(50+margin*3, 350, 70, 70)
        self.beacon15.frame = CGRectMake(50+margin*4, 350, 70, 70)
        self.beacon16.frame = CGRectMake(50, 490, 70, 70)
        self.beacon17.frame = CGRectMake(50+margin, 490, 70, 70)
        self.beacon18.frame = CGRectMake(50+margin*2, 490, 70, 70)
        self.beacon19.frame = CGRectMake(50+margin*3, 490, 70, 70)
        self.beacon20.frame = CGRectMake(50+margin*4, 490, 70, 70)
        self.addSubview(self.beacon1)
        self.addSubview(self.beacon2)
        self.addSubview(self.beacon3)
        self.addSubview(self.beacon4)
        self.addSubview(self.beacon5)
        self.addSubview(self.beacon6)
        self.addSubview(self.beacon7)
        self.addSubview(self.beacon8)
        self.addSubview(self.beacon9)
        self.addSubview(self.beacon10)
        self.addSubview(self.beacon11)
        self.addSubview(self.beacon12)
        self.addSubview(self.beacon13)
        self.addSubview(self.beacon14)
        self.addSubview(self.beacon15)
        self.addSubview(self.beacon16)
        self.addSubview(self.beacon17)
        self.addSubview(self.beacon18)
        self.addSubview(self.beacon19)
        self.addSubview(self.beacon20)
        
        self.beacon1.tag = 1
        self.beacon2.tag = 2
        self.beacon3.tag = 3
        self.beacon4.tag = 4
        self.beacon5.tag = 5
        self.beacon6.tag = 6
        self.beacon7.tag = 7
        self.beacon8.tag = 8
        self.beacon9.tag = 9
        self.beacon10.tag = 10
        self.beacon11.tag = 11
        self.beacon12.tag = 12
        self.beacon13.tag = 13
        self.beacon14.tag = 14
        self.beacon15.tag = 15
        self.beacon16.tag = 16
        self.beacon17.tag = 17
        self.beacon18.tag = 18
        self.beacon19.tag = 19
        self.beacon20.tag = 20
    }

    func drawLightEffect(id: Int){
        
    }
}
