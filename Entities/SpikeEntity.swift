//
//  SpikeEntity.swift
//  Cube Run: Origins
//
//  Created by Claude Code on 2026‑05‑15.
//

import SpriteKit

enum SpikeType {
    case normal
    case large
    case moving
}

final class SpikeEntity: SKSpriteNode {
    // MARK: - Init
    init(type: SpikeType) {
        // Choose a placeholder texture name based on the type.
        let textureName: String
        switch type {
        case .normal:
            textureName = "spike_normal"
        case .large:
            textureName = "spike_large"
        case .moving:
            textureName = "spike_normal"
        }
        let texture = SKTexture(imageNamed: textureName)
        super.init(texture: texture, color: .clear, size: texture.size())

        // Physics body – static obstacle.
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = Constants.obstacleCategory
        self.physicsBody?.contactTestBitMask = Constants.playerCategory
        self.physicsBody?.collisionBitMask = 0

        // Moving spikes: simple leftward motion using Constants.baseSpeed.
        if type == .moving {
            let move = SKAction.moveBy(x: -Constants.baseSpeed, y: 0, duration: 1.0)
            let repeatMove = SKAction.repeatForever(move)
            self.run(repeatMove, withKey: "movingSpike")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
