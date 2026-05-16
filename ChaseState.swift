// ChaseState.swift
import GameplayKit

class ChaseState: GKState {
    weak var stateMachineWrapper: GameStateMachine?

    init(stateMachine: GameStateMachine) {
        self.stateMachineWrapper = stateMachine
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        // Start chase mode (e.g., increase speed, spawn enemies)
    }

    override func update(deltaTime seconds: TimeInterval) {
        // Placeholder: transition to GameOverState after some condition
        // For now, directly transition after a fixed time
        // This would be replaced with real game logic
    }

    override func willExit(to nextState: GKState) {
        // Cleanup chase mode
    }
}
