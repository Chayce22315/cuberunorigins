//
//  AudioManager.swift
//  Cube Run: Origins
//
//  Created by Claude on 2026‑05‑15.
//

import SpriteKit
import AVFoundation

/// Centralised audio handling for background music and sound effects.
final class AudioManager {

    // MARK: - Singleton
    static let shared = AudioManager()

    // MARK: - Properties
    private var musicPlayer: AVAudioPlayer?
    private var effectPlayers: [String: AVAudioPlayer] = [:]

    // MARK: - Initialization
    private init() {
        // Pre‑load sound effects that are used frequently.
        preloadEffect(named: "jump")
        preloadEffect(named: "explosion")
        // TODO: add more preloads as needed.
    }

    // MARK: - Music

    /// Loads and plays background music on a loop.
    func playMusic() {
        guard let url = Bundle.main.url(forResource: "background_music", withExtension: "mp3") else {
            print("⚠️ AudioManager: background music file not found")
            return
        }
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer?.numberOfLoops = -1   // infinite loop
            musicPlayer?.prepareToPlay()
            musicPlayer?.play()
        } catch {
            print("❗️ AudioManager: failed to play music – \(error)")
        }
    }

    /// Stops the background music if it is playing.
    func stopMusic() {
        musicPlayer?.stop()
        musicPlayer = nil
    }

    // MARK: - Sound Effects

    /// Plays a sound‑effect by name. If the effect hasn't been loaded yet it will be loaded lazily.
    /// - Parameter name: The base filename of the effect (without extension).
    func playEffect(named name: String) {
        if let player = effectPlayers[name] {
            player.play()
            return
        }
        // Lazy load the effect.
        preloadEffect(named: name)
        effectPlayers[name]?.play()
    }

    /// Pre‑loads a sound effect into memory for faster subsequent playback.
    private func preloadEffect(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else {
            print("⚠️ AudioManager: effect '\(name)' not found")
            return
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            effectPlayers[name] = player
        } catch {
            print("❗️ AudioManager: failed to load effect '\(name)' – \(error)")
        }
    }
}
