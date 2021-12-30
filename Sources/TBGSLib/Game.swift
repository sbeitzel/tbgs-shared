//
//  Game.swift
//  
//
//  Created by Stephen Beitzel on 12/27/21.
//

import Foundation

/// Any turn-based game that the server can handle must implement this protocol.
public protocol Game {
    /// This unique ID identifies the game. It's used in turn submissions and in
    /// turn processing to make sure that the right set of rules are being used.
    var id: UUID { get }
    /// This string is used for display purposes, to list the games available on the server
    var shortName: String { get }
    /// This string is used for display purposes, as a further elaboration on the ``shortName``
    /// property.
    var description: String { get }

    /// Create a new match, with the specified player as the first participant.
    ///
    /// - Parameter playerOne: a player ID to be added to the ``Match`` as the first player
    /// - Returns a new ``Match`` for this game
    func newMatch(playerOne: UUID) -> Match

    /// Implement the game-specific deserialization logic here. Since ``Match`` is
    /// a protocol, every game will have some concrete type that implements it, and
    /// this method is where that concrete type gets instantiated from its serialized
    /// form.
    ///
    /// - Parameter data: the serialized match data
    /// - Returns an implementation-specific ``Match``
    func restoreMatch(data: Data) throws -> Match

    /// Accept a turn submission from a player, and return the updated turn number.
    ///
    /// - Parameter state: the ``Match`` to which this turn submission applies
    /// - Parameter player: the ID of the player submitting the turn
    /// - Parameter turn: the serialized turn submission
    /// - Returns the turn number the match will have after this turn submission is processed
    /// - Throws TBGSError.invalidEntity, TBGSError.notTurnForPlayer, TBGSError.turnOutOfSequence
    func acceptSubmission(for state: Match, from player: UUID, of turn: Data) throws -> Int

    /// Given all the players' turn submissions for the current turn, process them and update the
    /// match.
    ///
    /// Errors will be thrown if the turn submissions violate the rules of the game.
    ///
    /// - Parameter match: the match being played
    /// - Parameter playerTurns: the turn submissions to be processed
    /// - Returns the result of the turn
    /// - Throws TBGSError.incorrectDataFormat, TBGSError.notTurnForPlayer, TBGSError.turnOutOfSequence, TBGSError.invalidMove
    func processTurn(match: Match, playerTurns: [PlayerTurn]) throws -> TurnResult

    /// Evaluate the list of turn submissions for the specified match and determine if they're ready
    /// for processing.
    ///
    /// The logic here is game-specific, and amounts to, "Can we go, yet, or are we waiting for somebody?"
    ///
    /// - Parameter match: the match under consideration
    /// - Parameter playerTurns: the turn submissions that have come in for the current turn so far
    /// - Returns `true` if the match is ready to proceed
    func isReadyToProcess(match: Match, playerTurns: [PlayerTurn]) -> Bool
}

/// This is the plugin class that must be extended in concrete implementations, to allow
/// for dynamic loading of the game.
///
/// For example, imagine a game called "Jump rope", declared as:
/// `public struct JumpRope: Game {...}`
/// We would also expect to find, in the same library, a builder that will create one
/// of these structs:
/// `final class JumpRopeBuilder: GameBuilder { override func build() -> Game { JumpRope() }`
///
/// Finally, the library would need to contain a function to let the server look for the builder:
/// `@_cdecl("createGamePlugin") public func createGamePlugin() -> UnsafeMutableRawPointer {`
/// `  return Unmanaged.passRetained(JumpRopeBuilder()).toOpaque() }`
open class GameBuilder {
    public init() {}

    /// The method called by the game server to create an instance of the game
    ///
    /// - Returns: a concrete implementation of the ``Game`` protocol
    open func build() -> Game {
        fatalError("Must be overridden by implementors!")
    }
}
