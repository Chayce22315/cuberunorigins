//
//  EvilCubeEntity.swift
//  CubeRunOrigins
//

import GameplayKit
import SpriteKit

/// Entity representing the enemy "Evil Cube" (Alexander Yuyu).
final class EvilCubeEntity: GKEntity {
    // Components
    let renderComponent: RenderComponent
    let aiComponent: AIComponent

    override init() {
        // Use the generic RenderComponent (creates a placeholder sprite).
        self.renderComponent = RenderComponent()
        // Customize appearance for the enemy.
        if let sprite = renderComponent.spriteNode {
            sprite.color = Constants.Enemy.color
            sprite.size = CGSize(width: Constants.Enemy.size, height: Constants.Enemy.size)
            sprite.name = "evilCube"
            // Position off‑screen initially.
            sprite.position = CGPoint(x: -sprite.size.width, y: -sprite.size.height)
        }
        // AI component receives the same sprite.
        self.aiComponent = AIComponent(sprite: renderComponent.spriteNode!)
        super.init()
        addComponent(renderComponent)
        addComponent(aiComponent)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        fatalError("init(coder:) has not been implemented")
    }

    /// Activate the enemy by adding its sprite to the given scene.
    func activate(in scene: SKScene) {
        if let sprite = renderComponent.spriteNode {
            scene.addChild(sprite)
        }
    }
}
