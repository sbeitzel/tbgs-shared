//
//  TurnResult.swift
//  
//
//  Created by Stephen Beitzel on 12/28/21.
//

import Foundation

public struct TurnResult: Codable {
    public let state: MatchState
    public let players: [UUID]

    public init(state: MatchState, players: [UUID]) {
        self.state = state
        self.players = players
    }
}
