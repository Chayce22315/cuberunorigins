//
//  GameScene.swift
//  Cube Run: Origins
//
//  Created by Claude Code on 2026‑05‑15.
//

import SpriteKit

final class GameScene: SKScene {

    // MARK: - Managers & State
    private var stateMachine: GameStateMachine?
    private let obstacleManager = ObstacleManager.shared
    private let audioManager = AudioManager.shared
    private let uiManager = UIManager.shared
    private let cameraManager = CameraManager.shared
    private var player: PlayerEntity?

    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        // Physics world
        physicsWorld.gravity = Constants.gravity

        // UI
        uiManager.installUI(in: self)
        audioManager.playMusic()

        // Managers need the scene reference
        obstacleManager.scene = self
        cameraManager.configure(in: self, following: SKNode()) // placeholder – will be set after player created

        // Initialise state machine with MainMenuState as entry point
        let mainMenu = MainMenuState(stateMachine: nil) // will be replaced with proper init later
        stateMachine = GameStateMachine(initialState: mainMenu)
    }

    // MARK: - Frame Update
    private var lastUpdateTime: TimeInterval?
    override func update(_ currentTime: TimeInterval) {
        let delta = CGFloat((currentTime - (lastUpdateTime ?? currentTime)))
        lastUpdateTime = currentTime

        // Update state machine first
        stateMachine.update(deltaTime: delta)

        // Ensure player exists once we enter GameplayState
        if player == nil, stateMachine.currentState is GameplayState {
            player = PlayerEntity(position: CGPoint(x: size.width * 0.2, y: size.height * 0.5), in: self)
            if let playerNode = player?.node {
                playerNode.name = "player"
                addChild(playerNode)
                // Configure camera to follow the player
                cameraManager.configure(in: self, following: playerNode)
            }
        }

        // Managers update
        obstacleManager.update(deltaTime: delta)
        uiManager.update(deltaTime: delta)
        cameraManager.update(deltaTime: delta)
    }
}
