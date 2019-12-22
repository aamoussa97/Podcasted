//
//  AudioPlayerProvider.swift
//  Podcasted
//
//  Created by Ali Moussa on 09/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayerProvider {
    
    static let sharedProvider = AudioPlayerProvider()
    
    var avPlayer:AVPlayer?
    var avPlayerItem:AVPlayerItem?
    
    private init() {}
    
}
