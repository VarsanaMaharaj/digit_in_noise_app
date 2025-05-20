//
//  AudioPlayerDelegate.swift
//  hearXTest
//
//  Created by Varsana Maharaj on 2025/05/19.
//

import SwiftUI
import AVFAudio

class AudioPlayerDelegate: NSObject, AVAudioPlayerDelegate {
    private let completion: (() -> Void)?

    init(completion: (() -> Void)?) {
        self.completion = completion
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        completion?()
    }
}
