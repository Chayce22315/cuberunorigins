// GameplayState.swift
import GameplayKit

class GameplayState: GKState {
    weak var stateMachineWrapper: GameStateMachine?

    init(stateMachine: GameStateMachine) {
        self.stateMachineWrapper = stateMachine
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        // Setup gameplay elements
    }

    override func update(deltaTime seconds: TimeInterval) {
        // Placeholder: check score threshold for chase transition
        if let gsm = stateMachineWrapper,
           let scoreMgr = gsm.scoreManager as? ScoreManaging {
            // Assuming score manager has a currentScore property
            // Here we use a placeholder condition
            let currentScore = 0 // replace with actual score
            if currentScore >= Constants.chaseScoreThreshold {
                gsm.enter(ChaseState.self)
            }
        }
    }

    override func willExit(to nextState: GKState) {
        // Cleanup gameplay
    }
}
