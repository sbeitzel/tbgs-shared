//
//  TBGSError.swift
//  
//
//  Created by Stephen Beitzel on 12/28/21.
//

import Foundation

public enum TBGSError: Error {
    case invalidEntity,
         invalidMove,
         notTurnForPlayer,
         incorrectDataFormat,
         turnOutOfSequence
}
