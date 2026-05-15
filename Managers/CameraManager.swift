//
//  CameraManager.swift
//  Cube Run: Origins
//
//  Created by Claude on 2026‑05‑15.
//

import SpriteKit

/// Provides a smooth‑following camera that tracks a player node and can shake.
final class CameraManager {

    // MARK: - Singleton
    static let shared = CameraManager()

    // MARK: - Properties
    private var cameraNode: SKCameraNode?
    private weak var playerNode: SKNode?
    private let followLag: CGFloat = 0.1   // Larger = looser follow.

    // MARK: - Initialization
    private init() { }

    // MARK: - Public API

    /// Configures the manager for a given scene and the node it should follow.
    /// - Parameters:
    ///   - scene: The SKScene whose camera will be set up.
    ///   - player: The node to track (typically the player sprite).
    func configure(in scene: SKScene, following player: SKNode) {
        // Ensure the scene has a camera.
        if scene.camera == nil {
            let cam = SKCameraNode()
            scene.camera = cam
            scene.addChild(cam)
        }
        self.cameraNode = scene.camera
        self.playerNode = player
        // Position the camera initially on the player.
        cameraNode?.position = player.position
    }

    /// Call each frame to smoothly move the camera toward the player.
    /// - Parameter deltaTime: Elapsed time since the last update (unused but kept for symmetry).
    func update(deltaTime: TimeInterval) {
        guard let cam = cameraNode, let player = playerNode else { return }
        let offset = player.position - cam.position
        let move = offset * followLag
        cam.position += move
    }

    /// Triggers a brief camera shake.
    /// - Parameters:
    ///   - duration: How long the shake lasts.
    ///   - amplitude: Maximum displacement in points.
    func shake(duration: TimeInterval, amplitude: CGFloat) {
        guard let cam = cameraNode else { return }
        // Uses the SKAction.shake extension defined elsewhere.
        let shakeAction = SKAction.shake(duration: duration, amplitude: amplitude)
        cam.run(shakeAction, withKey: "cameraShake")
    }
}
