// MainMenuState.swift
import GameplayKit

class MainMenuState: GKState {
    weak var stateMachineWrapper: GameStateMachine?

    init(stateMachine: GameStateMachine) {
        self.stateMachineWrapper = stateMachine
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        // Setup main menu UI
    }

    override func update(deltaTime seconds: TimeInterval) {
        // Check for user input to start game
    }

    override func willExit(to nextState: GKState) {
        // Cleanup main menu UI
    }
}
