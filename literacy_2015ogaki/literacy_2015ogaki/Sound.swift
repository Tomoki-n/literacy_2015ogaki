//
//  Sound.swift
//  literacy_2015ogaki
//
//  Created by Nishinaka Tomoki on 2015/10/10.
//  Copyright © 2015年 Nishinaka Tomoki. All rights reserved.
//

import Foundation
import AVFoundation

class Sound :NSObject{
    var path:String?
    var player = AVAudioPlayer()
    var para :Int?
    func setfile(paths:String){
        
        
       
        let path = NSBundle.mainBundle().pathForResource(paths as String, ofType:"mp3")
        let url = NSURL.fileURLWithPath(path!)
        do {
            try self.player = AVAudioPlayer(contentsOfURL:url)
        } catch {
            print("error")
            //Handle the error
        }
        
        player.delegate = self
        player.prepareToPlay()
        player.volume = 1.0

    }
    func infstart(){
        player.play()
        player.numberOfLoops = -1
        print("infplay")
    }
    
    func start(){
        player.play()
    
    }
    
    func stop(){
        player.stop()
        
    }
    
    func ids(id:Int){
        switch id {
        case 0:
            setfile("battle")
            break
        case 1:
            setfile("bossbattle")
            break
        case 2:
            setfile("bubu")
            break
        case 3:
            setfile("claer")
            break
        case 4:
            setfile("deru")
            break
        case 5:
            setfile("field_ido")
            break
        case 6:
            setfile("field_kaigan")
            break
        case 7:
            setfile("field_mori")
            break
        case 8:
            setfile("field_sabaku")
            break
        case 9:
            setfile("field_souden")
            break
        case 10:
            setfile("kaihuku")
            break
        case 11:
            setfile("make")
            break
        case 12:
            setfile("panti")
            break
        case 13:
            setfile("seikai")
            break
        case 14:
            setfile("seikai2")
            break
        case 15:
            setfile("syutugen")
            break
        case 16:
            setfile("field_makai")
            break
        default:
            break
        }
        
        
        
    }
    
    func callfinish(){
        
       print("finish")
    }
    
    func vol(v:Float){
        player.volume = v
        
    }
    
}



// MARK: AVAudioPlayerDelegate
extension Sound : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing \(flag)")
        
            callfinish()
            
        
        
    }
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        print("\(error!.localizedDescription)")
    }
}
