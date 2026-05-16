//
//  MovementComponent.swift
//  CubeRunOrigins
//

import GameplayKit
import SpriteKit

/// Handles simple forward‑movement and jump logic for the player.
final class MovementComponent: GKComponent {

    /// Movement speed in points per second.
    var speed: CGFloat = Constants.Player.movementSpeed

    /// Impulse applied when the player jumps.
    var jumpImpulse: CGFloat = Constants.Player.jumpImpulse

    private weak var node: SKNode? {
        // The node is provided by the RenderComponent (or the entity’s root node).
        return (entity?.component(ofType: RenderComponent.self))?.spriteNode
    }

    /// Called each frame by the scene (or a system) with the elapsed time.
    override func update(deltaTime seconds: TimeInterval) {
        guard let node = node else { return }

        // Simple horizontal movement – could be expanded to input handling.
        let dx = speed * CGFloat(seconds)
        node.position.x += dx
    }

    /// Trigger a jump – adds an upward impulse to the physics body.
    func jump() {
        guard
            let physics = entity?.component(ofType: PhysicsComponent.self)?.physicsBody,
            physics.velocity.dy == 0   // allow jump only when on the ground
        else { return }

        physics.applyImpulse(CGVector(dx: 0, dy: jumpImpulse))
    }
}
