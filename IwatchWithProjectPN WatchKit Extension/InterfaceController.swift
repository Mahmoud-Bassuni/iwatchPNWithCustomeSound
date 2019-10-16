//
//  InterfaceController.swift
//  IwatchWithProjectPN WatchKit Extension
//
//  Created by Bassuni on 10/15/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import WatchKit
import Foundation
import AVFoundation

class InterfaceController: WKInterfaceController {
    var player: AVAudioPlayer?
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        playSound();
        // Configure interface objects here.
    }
    func playSound() {
         guard let url = Bundle.main.url(forResource: "whistle_twice", withExtension: "mp3") else { return }

         do {
             try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
             try AVAudioSession.sharedInstance().setActive(true)

             /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

             /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

             guard let player = player else { return }

             player.play()

         } catch let error {
             print(error.localizedDescription)
         }
     }
    override func willActivate() {
        playSound() 
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
