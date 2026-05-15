//
//  PhysicsComponent.swift
//  CubeRunOrigins
//

import GameplayKit
import SpriteKit

/// Sets up the physics body for the player sprite.
final class PhysicsComponent: GKComponent {

    /// The physics body attached to the player node.
    let physicsBody: SKPhysicsBody

    init(size: CGSize) {
        // Simple rectangular body; you can switch to circle or texture‑based shape.
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody.isDynamic = true
        self.physicsBody.allowsRotation = false

        // Category / collision / contact masks from a shared Constants definition.
        self.physicsBody.categoryBitMask = Constants.PhysicsCategory.player
        self.physicsBody.collisionBitMask = Constants.PhysicsCategory.world
        self.physicsBody.contactTestBitMask = Constants.PhysicsCategory.world
    }

    override func didAddToEntity() {
        // Attach the body to the node created by RenderComponent.
        if let node = (entity?.component(ofType: RenderComponent.self))?.spriteNode {
            node.physicsBody = physicsBody
        }
    }
}
