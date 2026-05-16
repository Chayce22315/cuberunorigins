//
//  AudioComponent.swift
//  CubeRunOrigins
//

import GameplayKit
import AVFoundation

/// Very lightweight sound player — plays short effect files from the bundle.
final class AudioComponent: GKComponent {

    private var audioPlayers: [String: AVAudioPlayer] = [:]

    /// Play a sound file that resides in the app bundle.
    /// - Parameter name: Filename without extension (e.g. "jump").
    func playSound(named name: String) {
        // Reuse existing player if already loaded.
        if let player = audioPlayers[name] {
            player.play()
            return
        }

        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else {
            // In a prototype we silently ignore missing files.
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            audioPlayers[name] = player
        } catch {
            // In a real project you’d log this error.
        }
    }
}
