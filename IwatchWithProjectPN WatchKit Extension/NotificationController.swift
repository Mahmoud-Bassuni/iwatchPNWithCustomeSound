//
//  NotificationController.swift
//  IwatchWithProjectPN WatchKit Extension
//
//  Created by Bassuni on 10/15/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications
import AVFoundation



class NotificationController: WKUserNotificationInterfaceController {
    var player: AVAudioPlayer?
    override init() {
        // Initialize variables here.
        super.init()
        playSound()
        // Configure interface objects here.
    }


  func playSound() {
       guard let url = Bundle.main.url(forResource: "piano-composition-40-46458", withExtension: "mp3") else { return }

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
        // This method is called when watch view controller is about to be visible to user
        playSound()
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

        override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Swift.Void) {
            // This method is called when a notification needs to be presented.
            // Implement it if you use a dynamic notification interface.
            // Populate your dynamic notification interface as quickly as possible.
            //
            // After populating your dynamic notification interface call the completion block.
            completionHandler(.custom)
        }
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent: UNNotification, withCompletionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        self.player?.stop()
    }

    override func didReceive(_ notification: UNNotification) {

        print("HI");
        playSound()
        // This method is called when a notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
    }
    func didReceiveRemoteNotification(_ remoteNotification: [AnyHashable : Any], withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Void) {
        playSound()


      }

    
}
