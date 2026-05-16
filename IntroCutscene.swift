import SpriteKit
import GameplayKit

/// State that presents the introductory cutscene with lore text.
final class IntroCutsceneState: GKState {
    // The scene where the cutscene is displayed.
    private weak var scene: SKScene?

    // MARK: - Initialization
    init(scene: SKScene) {
        self.scene = scene
        super.init()
    }

    // MARK: - GKState Overrides
    override func didEnter(from previousState: GKState?) {
        guard let scene = scene else { return }
        // Ensure the background is black.
        scene.backgroundColor = .black
        // Add a brief flash effect.
        addFlashEffect(to: scene)
        // Show the lore lines.
        presentLore(in: scene) {
            // After the intro duration, transition to the gameplay state.
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.introDuration) { [weak self] in
                // Guard against the state machine being nil.
                guard let self = self else { return }
                self.stateMachine?.enter(GameplayState.self)
            }
        }
    }

    // MARK: - Private Helpers
    /// Adds a quick white flash that fades out.
    private func addFlashEffect(to scene: SKScene) {
        let flash = SKSpriteNode(color: .white, size: scene.size)
        flash.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        flash.zPosition = 1000
        flash.alpha = 0.0
        scene.addChild(flash)
        let flashSequence = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.8, duration: 0.1),
            SKAction.fadeAlpha(to: 0.0, duration: 0.2)
        ])
        flash.run(flashSequence) {
            flash.removeFromParent()
        }
    }

    /// Presents the lore lines one after another with a fade‑in effect.
    /// - Parameters:
    ///   - scene: The scene to which the labels are added.
    ///   - completion: Called after all lines have been shown.
    private func presentLore(in scene: SKScene, completion: @escaping () -> Void) {
        let loreLines = [
            "the grid was never meant to think",
            "but one cube did",
            "and the world will never be the same"
        ]
        var actions: [SKAction] = []
        let labelFont = "Helvetica-Bold"
        let labelFontSize: CGFloat = 24.0
        let labelColor = SKColor.white
        let verticalSpacing: CGFloat = 40.0
        let startY = scene.size.height / 2 + CGFloat(loreLines.count - 1) * verticalSpacing / 2
        for (index, line) in loreLines.enumerated() {
            let label = SKLabelNode(fontNamed: labelFont)
            label.text = line
            label.fontSize = labelFontSize
            label.fontColor = labelColor
            label.alpha = 0.0
            label.position = CGPoint(x: scene.size.width / 2, y: startY - CGFloat(index) * verticalSpacing)
            label.zPosition = 999
            scene.addChild(label)
            // Fade‑in, hold, then fade‑out (optional)
            let fadeIn = SKAction.fadeIn(withDuration: 0.8)
            let wait = SKAction.wait(forDuration: 1.0)
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)
            let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
            actions.append(sequence)
            // Run action on the label after a short delay so lines appear sequentially.
            let delay = SKAction.wait(forDuration: Double(index) * 2.0)
            label.run(SKAction.sequence([delay, sequence]))
        }
        // Call completion after the total duration of the last line.
        let totalDuration = Double(loreLines.count - 1) * 2.0 + 2.3 // approximate
        scene.run(SKAction.wait(forDuration: totalDuration), completion: completion)
    }
}
