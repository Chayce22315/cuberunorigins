//
//  ChaseEvent.swift
//  Cube Run: Origins
//
//  Created by Claude Code on 2026‑05‑15.
//

import SpriteKit
import GameplayKit

final class ChaseEventState: GKState {
    weak var stateMachineWrapper: GameStateMachine?
    private weak var scene: SKScene?
    private var player: PlayerEntity?

    init(stateMachine: GameStateMachine?, scene: SKScene?, player: PlayerEntity?) {
        self.stateMachineWrapper = stateMachine
        self.scene = scene
        self.player = player
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        guard let scene = scene else { return }
        // Increase player speed via MovementComponent
        if let movement = player?.component(ofType: MovementComponent.self) {
            movement.speed *= Constants.chaseSpeedMultiplier
        }
        // Play intense chase music
        AudioManager.shared.playEffect(named: "chase_music")
        // Show warning label
        let warning = SKLabelNode(fontNamed: "AvenirNext-Bold")
        warning.text = "HE FOUND YOU"
        warning.fontSize = 30
        warning.fontColor = .red
        warning.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        warning.zPosition = 1000
        warning.alpha = 0
        scene.addChild(warning)
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        let wait = SKAction.wait(forDuration: 2.0)
        let fadeOut = SKAction.fadeOut(withDuration: 0.3)
        warning.run(SKAction.sequence([fadeIn, wait, fadeOut]))

        // Trigger a visual glitch
        GlitchManager.shared.triggerRandomGlitch(in: scene)

        // After chase duration, revert to normal gameplay
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.chaseDuration) { [weak self] in
            // Reset speed
            if let movement = self?.player?.component(ofType: MovementComponent.self) {
                movement.speed = Constants.baseSpeed
            }
            // Transition back
            if let gsm = self?.stateMachineWrapper {
                gsm.enter(GameplayState.self)
            }
        }
    }
}
