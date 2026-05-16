//
//  AIComponent.swift
//  CubeRunOrigins
//

import GameplayKit
import SpriteKit

/// Simple AI component for the EvilCube enemy.
final class AIComponent: GKComponent {
    enum State {
        case idle
        case watchingPlayer
        case chasing
    }

    private weak var sprite: SKSpriteNode?
    private var state: State = .idle
    private var timer: TimeInterval = 0

    init(sprite: SKSpriteNode) {
        self.sprite = sprite
        super.init()
        scheduleNextAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func scheduleNextAction() {
        // Random interval between 1–3 seconds before next evaluation.
        timer = TimeInterval.random(in: 1.0...3.0)
    }

    override func update(deltaTime seconds: TimeInterval) {
        guard let sprite = sprite, let scene = sprite.scene else { return }
        timer -= seconds
        if timer <= 0 {
            // Randomly pick a new state.
            let choice = Int.random(in: 0...2)
            switch choice {
            case 0: state = .idle
            case 1: state = .watchingPlayer
            default: state = .chasing
            }

            // Occasionally emit a glitch effect.
            if Bool.random() {
                // Supply the current scene to the manager.
                GlitchManager.shared.triggerRandomGlitch(in: scene)
            }

            // Placeholder: position enemy behind the player.
            if let player = scene.childNode(withName: "player") as? SKSpriteNode {
                // Use a constant offset defined in Constants (you may need to add this later).
                let offset = CGVector(dx: -50, dy: 0) // simple static offset
                sprite.position = player.position + offset
            }

            scheduleNextAction()
        }
    }
}

// Helper to add a CGVector to a CGPoint.
extension CGPoint {
    static func + (left: CGPoint, right: CGVector) -> CGPoint {
        return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
    }
}
