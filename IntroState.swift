// IntroState.swift
import GameplayKit

class IntroState: GKState {
    weak var stateMachineWrapper: GameStateMachine?

    init(stateMachine: GameStateMachine) {
        self.stateMachineWrapper = stateMachine
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        // Play intro animation or cutscene
    }

    override func update(deltaTime seconds: TimeInterval) {
        // Transition to GameplayState after intro finishes
        // Placeholder: immediately transition for now
        if let gsm = stateMachineWrapper {
            gsm.enter(GameplayState.self)
        }
    }

    override func willExit(to nextState: GKState) {
        // Cleanup intro resources
    }
}
