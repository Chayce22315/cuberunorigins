// GameOverState.swift
import GameplayKit

class GameOverState: GKState {
    weak var stateMachineWrapper: GameStateMachine?

    init(stateMachine: GameStateMachine) {
        self.stateMachineWrapper = stateMachine
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        // Show game over UI, final score, etc.
    }

    override func update(deltaTime seconds: TimeInterval) {
        // Await player input to go back to main menu or restart
    }

    override func willExit(to nextState: GKState) {
        // Cleanup game over UI
    }
}
