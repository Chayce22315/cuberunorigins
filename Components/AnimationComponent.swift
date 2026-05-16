//
//  AnimationComponent.swift
//  CubeRunOrigins
//

import GameplayKit
import SpriteKit

/// Provides simple idle and jump animations.
final class AnimationComponent: GKComponent {

    private weak var sprite: SKSpriteNode? {
        return (entity?.component(ofType: RenderComponent.self))?.spriteNode
    }

    // MARK: - Actions

    private lazy var idleAction: SKAction = {
        // Simple scaling pulse to hint at “idle”.
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        return SKAction.repeatForever(SKAction.sequence([scaleUp, scaleDown]))
    }()

    private lazy var jumpAction: SKAction = {
        // Quick upward‑then‑downward move (the physics body will also move).
        let moveUp = SKAction.moveBy(x: 0, y: 10, duration: 0.1)
        let moveDown = SKAction.moveBy(x: 0, y: -10, duration: 0.1)
        return SKAction.sequence([moveUp, moveDown])
    }()

    // MARK: - Public API

    func startIdle() {
        sprite?.run(idleAction, withKey: "idle")
    }

    func stopIdle() {
        sprite?.removeAction(forKey: "idle")
    }

    func playJump() {
        // Play the short jump visual on top of any idle animation.
        sprite?.run(jumpAction)
    }

    override func didAddToEntity() {
        // Begin idle animation automatically.
        startIdle()
    }
}
