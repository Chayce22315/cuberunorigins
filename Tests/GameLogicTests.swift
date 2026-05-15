//
//  GameLogicTests.swift
//  Cube Run: Origins Tests
//
//  Created by Claude Code on 2026‑05‑15.
//

import XCTest
import SpriteKit
@testable import CubeRunOrigins

final class GameLogicTests: XCTestCase {

    func testObstacleSpawnInterval() {
        // Set up a dummy scene.
        let scene = SKScene(size: CGSize(width: 640, height: 480))
        ObstacleManager.shared.scene = scene
        // Verify timer starts at the constant value.
        XCTAssertEqual(ObstacleManager.shared.spawnTimer, Constants.obstacleSpawnInterval)
        // Advance time beyond the interval.
        ObstacleManager.shared.update(deltaTime: Constants.obstacleSpawnInterval + 0.1)
        // After update, a child should have been added.
        XCTAssertTrue(scene.children.contains { $0 is SpikeEntity })
    }

    func testGlitchManagerRandomSelection() {
        let scene = SKScene(size: CGSize(width: 640, height: 480))
        var overlayFound = false
        var shakeFound = false
        // Run many times to increase chance of both effects.
        for _ in 0..<20 {
            GlitchManager.shared.triggerRandomGlitch(in: scene)
            // Check for overlay node.
            if scene.children.contains(where: { $0 is SKSpriteNode && $0.alpha > 0 && $0.zPosition == 1000 }) {
                overlayFound = true
            }
            // Since shake runs on the scene node, we cannot directly inspect, but we can check actions.
            if scene.hasActions() { // simplistic check
                shakeFound = true
            }
        }
        XCTAssertTrue(overlayFound, "Overlay glitch should have been triggered at least once")
        XCTAssertTrue(shakeFound, "Shake glitch should have been triggered at least once")
    }
}
