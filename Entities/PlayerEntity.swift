//
//  PlayerEntity.swift
//  CubeRunOrigins
//

import GameplayKit
import SpriteKit

/// Assembles all player‑related components into a single GKEntity.
final class PlayerEntity: GKEntity {

    /// Convenience accessor for the sprite node.
    var node: SKSpriteNode? {
        return component(ofType: RenderComponent.self)?.spriteNode
    }

    /// Initialise the player at a given location and add it to a scene.
    /// - Parameters:
    ///   - position: Starting position in scene coordinates.
    ///   - scene:    The SKScene that will host the player.
    init(position: CGPoint, in scene: SKScene) {
        super.init()

        // 1. Render component creates the visual node.
        let render = RenderComponent()
        addComponent(render)

        // 2. Physics component uses the same size as the sprite.
        let physics = PhysicsComponent(size: render.spriteNode.size)
        addComponent(physics)

        // 3. Movement, animation and audio components.
        addComponent(MovementComponent())
        addComponent(AnimationComponent())
        addComponent(AudioComponent())

        // Position the sprite and add it to the scene.
        render.spriteNode.position = position
        render.addToScene(scene)

        // The physics body is attached automatically in PhysicsComponent.didAddToEntity.
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
