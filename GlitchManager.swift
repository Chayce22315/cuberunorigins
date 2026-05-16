//
//  GlitchManager.swift
//  Cube Run: Origins
//
//  Created by Claude Code.
//

import GameplayKit
import SpriteKit

/// Simple constants used across the glitch system.
struct GlitchManagerConstants {
    /// Duration for glitch effects.
    static let glitchDuration: TimeInterval = 0.3
}

/// Extension providing a basic screen‑shake action.
extension SKAction {
    /// Creates a shake action that moves the node randomly.
    /// - Parameters:
    ///   - duration: How long the shake lasts.
    ///   - amplitude: Maximum offset distance for each shake step.
    static func shake(duration: TimeInterval, amplitude: CGFloat) -> SKAction {
        let shakeCount = Int(duration / 0.04)
        var actions: [SKAction] = []
        for _ in 0..<shakeCount {
            let offsetX = CGFloat.random(in: -amplitude...amplitude)
            let offsetY = CGFloat.random(in: -amplitude...amplitude)
            let move = SKAction.moveBy(x: offsetX, y: offsetY, duration: 0.02)
            let reverse = move.reversed()
            actions.append(move)
            actions.append(reverse)
        }
        return SKAction.sequence(actions)
    }
}

/// Singleton responsible for triggering random glitch effects in the current scene.
final class GlitchManager {
    static let shared = GlitchManager()
    private init() {}

    /// Randomly selects a glitch type and applies it to the provided scene.
    /// Currently supports two simple effects:
    ///   1. A semi‑transparent white overlay that fades out.
    ///   2. A screen‑shake effect.
    func triggerRandomGlitch(in scene: SKScene) {
        let glitchType = Int.random(in: 0..<2)
        switch glitchType {
        case 0:
            // Overlay effect.
            let overlay = SKSpriteNode(color: UIColor(white: 1.0, alpha: 0.5), size: scene.size)
            overlay.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
            overlay.zPosition = 1000
            overlay.alpha = 0.0
            scene.addChild(overlay)
            let fade = SKAction.fadeOut(withDuration: GlitchManagerConstants.glitchDuration)
            overlay.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.05), fade]))
        case 1:
            // Shake effect.
            let shake = SKAction.shake(duration: GlitchManagerConstants.glitchDuration, amplitude: 10)
            scene.run(shake)
        default:
            break
        }
    }
}
