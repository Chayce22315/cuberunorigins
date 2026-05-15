// GameStateMachine.swift
import SpriteKit
import GameplayKit

// Placeholder manager protocols/classes
protocol AudioManaging { }
protocol InputManaging { }
protocol ScoreManaging { }

class GameStateMachine {
    private let stateMachine: GKStateMachine
    var currentScene: SKScene?
    var audioManager: AudioManaging?
    var inputManager: InputManaging?
    var scoreManager: ScoreManaging?

    init(initialState: GKState) {
        // Initialize with the provided initial state
        self.stateMachine = GKStateMachine(states: [initialState])
        self.stateMachine.enter(initialState)
    }

    func update(deltaTime seconds: TimeInterval) {
        stateMachine.update(deltaTime: seconds)
    }

    func enter(_ stateClass: GKState.Type) {
        guard let state = stateMachine.state(forClass: stateClass) else { return }
        stateMachine.enter(state)
    }

    var currentState: GKState? {
        return stateMachine.currentState
    }
}
