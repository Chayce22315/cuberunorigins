//
//  RenderComponent.swift
//  CubeRunOrigins
//

import GameplayKit
import SpriteKit

/// Creates and owns the visual representation of the player.
final class RenderComponent: GKComponent {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    /// The sprite shown on‑screen.
    let spriteNode: SKSpriteNode

    init() {
        // Placeholder sprite — a solid‑color square.
        let size = CGSize(width: Constants.Player.size,
                          height: Constants.Player.size)
        spriteNode = SKSpriteNode(color: Constants.Player.color,
                                  size: size)

        // Anchor point at the center (default) makes positioning easier.
        spriteNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }

    /// Adds the sprite to a given scene. Called by `PlayerEntity`.
    func addToScene(_ scene: SKScene) {
        scene.addChild(spriteNode)
    }
}
