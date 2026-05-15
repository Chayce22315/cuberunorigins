//
//  UIManager.swift
//  Cube Run: Origins
//
//  Created by Claude on 2026‑05‑15.
//

import SpriteKit

/// Handles UI elements such as the score display and simple overlay menus.
final class UIManager {

    // MARK: - Singleton
    static let shared = UIManager()

    // MARK: - Properties
    private var scoreLabel: SKLabelNode?
    private var pauseMenu: SKNode?
    private var gameOverMenu: SKNode?
    private var currentScore: Int = 0

    // MARK: - Initialization
    private init() { }

    // MARK: - Public API

    /// Installs UI elements into the given scene. Call once during scene setup.
    /// - Parameter scene: The SKScene that will host the UI.
    func installUI(in scene: SKScene) {
        // Score label – top‑right corner.
        let label = SKLabelNode(fontNamed: "AvenirNext-Bold")
        label.fontSize = 24
        label.fontColor = SKColor.white
        label.horizontalAlignmentMode = .right
        label.verticalAlignmentMode = .top
        label.position = CGPoint(x: scene.size.width - 20, y: scene.size.height - 20)
        label.text = "Score: 0"
        scene.addChild(label)
        self.scoreLabel = label

        // Stub pause/menu nodes – hidden by default.
        pauseMenu = SKNode()
        gameOverMenu = SKNode()
        scene.addChild(pauseMenu!)
        scene.addChild(gameOverMenu!)
        pauseMenu?.isHidden = true
        gameOverMenu?.isHidden = true
        // TODO: populate menus with buttons, backgrounds, etc.
    }

    /// Call each frame (or whenever the score changes) to refresh the displayed score.
    func update(deltaTime: TimeInterval) {
        // In a real implementation the score would be tracked elsewhere; here we simply redraw.
        scoreLabel?.text = "Score: \(currentScore)"
    }

    /// Adjusts the internal score and updates the label.
    /// - Parameter amount: The amount to add (or subtract) from the score.
    func addScore(_ amount: Int) {
        currentScore += amount
        scoreLabel?.text = "Score: \(currentScore)"
    }

    // MARK: - Menu helpers

    func showPauseMenu() {
        pauseMenu?.isHidden = false
        // TODO: animate, add buttons.
    }

    func hidePauseMenu() {
        pauseMenu?.isHidden = true
    }

    func showGameOverMenu() {
        gameOverMenu?.isHidden = false
        // TODO: display final score, retry button.
    }

    func hideGameOverMenu() {
        gameOverMenu?.isHidden = true
    }
}
