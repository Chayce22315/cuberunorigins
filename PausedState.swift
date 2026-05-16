// PausedState.swift
import GameplayKit

class PausedState: GKState {
    weak var stateMachineWrapper: GameStateMachine?

    init(stateMachine: GameStateMachine) {
        self.stateMachineWrapper = stateMachine
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        // Pause the scene, timers, etc.
        stateMachineWrapper?.currentScene?.isPaused = true
    }

    override func update(deltaTime seconds: TimeInterval) {
        // Wait for unpause input
    }

    override func willExit(to nextState: GKState) {
        // Resume the scene
        stateMachineWrapper?.currentScene?.isPaused = false
    }
}
