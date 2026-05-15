//
//  ObstacleManager.swift
//  Cube Run: Origins
//
//  Created by Claude on 2026‑05‑15.
//

import SpriteKit
import GameplayKit

/// Simple stub for an obstacle entity. In a full implementation this would be a
/// subclass of SKSpriteNode (or similar) with its own behaviour.
final class SpikeEntity: SKSpriteNode {
    enum SpikeType {
        case normal
        case large
        case moving
    }

    init(type: SpikeType) {
        // Placeholder texture – replace with real assets later.
        let texture = SKTexture(imageNamed: "spike_\(type)")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.name = "SpikeEntity"
        // TODO: configure physics body, movement, etc. based on `type`.
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Manages spawning of obstacle entities at regular intervals.
final class ObstacleManager {

    // MARK: - Singleton
    static let shared = ObstacleManager()

    // MARK: - Properties
    private let randomSource = GKRandomSource.sharedRandom()
    var spawnTimer: TimeInterval = Constants.obstacleSpawnInterval

    // The scene that obstacles should be added to.
    weak var scene: SKScene?

    // MARK: - Initialization
    private init() { }

    // MARK: - Public API

    /// Call each frame (or on a fixed‑time step) to update the spawn timer.
    /// When the timer reaches zero a new obstacle is created and added to the scene.
    /// - Parameter deltaTime: Time elapsed since the last update call.
    func update(deltaTime: TimeInterval) {
        guard let scene = scene else { return }

        spawnTimer -= deltaTime
        if spawnTimer <= 0 {
            spawnTimer = Constants.obstacleSpawnInterval
            let obstacle = createRandomObstacle()
            // Position the obstacle off‑screen to the right (example).
            obstacle.position = CGPoint(x: scene.size.width + obstacle.size.width,
                                        y: CGFloat.random(in: 0...scene.size.height))
            scene.addChild(obstacle)
        }
    }

    // MARK: - Private Helpers

    private func createRandomObstacle() -> SpikeEntity {
        // Simple random selection between a few obstacle types.
        let types: [SpikeEntity.SpikeType] = [.normal, .large, .moving]
        let index = randomSource.nextInt(upperBound: types.count)
        let selectedType = types[index]
        return SpikeEntity(type: selectedType)
    }
}
