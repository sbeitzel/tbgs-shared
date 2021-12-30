//
//  Match.swift
//  
//
//  Created by Stephen Beitzel on 12/27/21.
//

import Foundation

public protocol Match {
    var gameID: UUID { get }
    var id: UUID { get }

    var isFull: Bool { get set }
    var state: MatchState { get set }

    var currentTurnSequence: Int { get }
    func incrementTurnSequence()

    func add(player: UUID) -> Bool
    var players: [UUID] { get }

    func encodeForDatabase() throws -> Data
    func encode(for player: UUID) throws -> Data

    func isTurn(for player: UUID) -> Bool
}
