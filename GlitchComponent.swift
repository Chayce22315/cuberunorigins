//
//  GlitchComponent.swift
//  Cube Run: Origins
//
//  Created by Claude Code.
//

import GameplayKit
import SpriteKit

/// Simple constants used across the glitch system.
struct GlitchConstants {
    /// Duration for glitch effects.
    static let glitchDuration: TimeInterval = 0.3
}

/// A `GKComponent` that can be attached to any entity to trigger a visual glitch aura.
final class GlitchComponent: GKComponent {
    /// The node that will receive the visual glitch.
    private weak var targetNode: SKNode?

    /// Create the component with the node to affect.
    init(node: SKNode) {
        self.targetNode = node
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Triggers a brief color‑flicker glitch on the attached node.
    /// The node flickers between red and white for a short period and then reverts to its original color.
    func triggerGlitch() {
        guard let sprite = targetNode as? SKSpriteNode else { return }
        // Preserve original visual state.
        let originalColor = sprite.color
        let originalBlend = sprite.colorBlendFactor

        // Prepare the flicker sequence.
        let flicker = SKAction.sequence([
            SKAction.run { sprite.color = .red; sprite.colorBlendFactor = 1.0 },
            SKAction.wait(forDuration: 0.05),
            SKAction.run { sprite.color = .white },
            SKAction.wait(forDuration: 0.05),
            SKAction.run { sprite.color = .red },
            SKAction.wait(forDuration: 0.05),
            SKAction.run { sprite.color = .white }
        ])

        // Revert to the original appearance after a short delay.
        let revert = SKAction.run {
            node.color = originalColor
            node.colorBlendFactor = originalBlend
        }

        let fullSequence = SKAction.sequence([
            flicker,
            SKAction.wait(forDuration: 0.2),
            revert
        ])

        sprite.run(fullSequence)
    }
}
