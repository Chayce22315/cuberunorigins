//
//  IntroCutscene.swift
//  Cube Run: Origins
//
//  Created by Claude Code on 2026‑05‑15.
//

import SpriteKit
import GameplayKit

final class IntroCutsceneState: GKState {
    weak var stateMachineWrapper: GameStateMachine?
    private var scene: SKScene?

    init(stateMachine: GameStateMachine?, scene: SKScene?) {
        self.stateMachineWrapper = stateMachine
        self.scene = scene
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        guard let scene = scene else { return }
        // Black background
        scene.backgroundColor = .black

        // Lore lines
        let lines = [
            "the grid was never meant to think",
            "but one cube did",
            "Alexander Yuyu has awakened"
        ]
        var delay: TimeInterval = 0.5
        for text in lines {
            let label = SKLabelNode(fontNamed: "AvenirNext-Bold")
            label.text = text
            label.fontSize = 24
            label.fontColor = .white
            label.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
            label.alpha = 0
            scene.addChild(label)
            let fadeIn = SKAction.fadeIn(withDuration: 0.5)
            let wait = SKAction.wait(forDuration: 1.0)
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)
            let sequence = SKAction.sequence([SKAction.wait(forDuration: delay), fadeIn, wait, fadeOut])
            label.run(sequence)
            delay += 2.0
        }

        // Static flash effect (quick white overlay)
        let flash = SKSpriteNode(color: .white, size: scene.size)
        flash.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        flash.zPosition = 1000
        flash.alpha = 0
        scene.addChild(flash)
        let flashSeq = SKAction.sequence([
            SKAction.wait(forDuration: 0.1),
            SKAction.fadeAlpha(to: 0.8, duration: 0.05),
            SKAction.fadeOut(withDuration: 0.2)
        ])
        flash.run(flashSeq)

        // Transition to GameplayState after the intro duration.
        let totalDuration = delay + 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration) { [weak self] in
            if let gsm = self?.stateMachineWrapper {
                gsm.enter(GameplayState.self)
            }
        }
    }
}
