//
//  mapView.swift
//  literacy_2015ogaki
//
//  Created by 山口将槻 on 2015/09/24.
//  Copyright (c) 2015年 Nishinaka Tomoki. All rights reserved.
//

import UIKit

class mapView: UIImageView {
    
    
    var hilightedBeacon = UIImageView(image: UIImage(named: "ringYellow.png"))

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    
    func drawBeacons(){
        self.hilightedBeacon.frame = CGRectMake(0, 0, 70, 70)
        self.hilightedBeacon.hidden = true
    }

    func drawEffectonBeacon(id: Int){
        self.hilightedBeacon.hidden = true
        switch id {
        case 1:
            self.hilightedBeacon.frame = self.beacon1.frame
            break
        case 2:
            self.hilightedBeacon.frame = self.beacon2.frame
            break
        case 3:
            self.hilightedBeacon.frame = self.beacon3.frame
            break
        case 4:
            self.hilightedBeacon.frame = self.beacon4.frame
            break
        case 5:
            self.hilightedBeacon.frame = self.beacon5.frame
            break
        case 6:
            self.hilightedBeacon.frame = self.beacon6.frame
            break
        case 7:
            self.hilightedBeacon.frame = self.beacon7.frame
            break
        case 8:
            self.hilightedBeacon.frame = self.beacon8.frame
            break
        case 9:
            self.hilightedBeacon.frame = self.beacon9.frame
            break
        case 10:
            self.hilightedBeacon.frame = self.beacon10.frame
            break
        case 11:
            self.hilightedBeacon.frame = self.beacon11.frame
            break
        case 12:
            self.hilightedBeacon.frame = self.beacon12.frame
            break
        case 13:
            self.hilightedBeacon.frame = self.beacon13.frame
            break
        case 14:
            self.hilightedBeacon.frame = self.beacon14.frame
            break
        case 15:
            self.hilightedBeacon.frame = self.beacon15.frame
            break
        case 16:
            self.hilightedBeacon.frame = self.beacon16.frame
            break
        case 17:
            self.hilightedBeacon.frame = self.beacon17.frame
            break
        case 18:
            self.hilightedBeacon.frame = self.beacon18.frame
            break
        case 19:
            self.hilightedBeacon.frame = self.beacon19.frame
            break
        case 20:
            self.hilightedBeacon.frame = self.beacon20.frame
            break
        default :
            break
        }
        self.hilightedBeacon.hidden = false
    }
}
