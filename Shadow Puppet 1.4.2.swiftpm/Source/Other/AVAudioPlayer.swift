//
//  AVAudioPlayer.swift
//
//
//  Created by Li Zhicheng on 2024/2/20.
//

import Foundation
import AVFoundation

class Sounds {
    static var audioPlayer: AVAudioPlayer!
    
    static func loop(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: .mixWithOthers)
                audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            } catch {
                print("Error playing sound \(error)")
            }
        } else {
            print("Error: cannot found music")
        }
    }
    
    static func play(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: .mixWithOthers)
                audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
                audioPlayer?.play()
            } catch {
                print("Error playing sound")
            }
        } else {
            print("Error: cannot found music")
        }
    }
}
