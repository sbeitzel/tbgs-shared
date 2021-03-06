//
//  File.swift
//  
//
//  Created by Stephen Beitzel on 12/28/21.
//

import Foundation

public struct PlayerTurn: Codable {
    public let playerID: UUID
    public let gameID: UUID
    public let matchID: UUID
    public let turnData: Data

    public init(playerID: UUID, gameID: UUID, matchID: UUID, turnData: Data) {
        self.playerID = playerID
        self.gameID = gameID
        self.matchID = matchID
        self.turnData = turnData
    }
}
