//
//  Notification.swift
//  
//
//  Created by Stephen Beitzel on 2/2/22.
//

import Foundation

struct Notification: Codable {
    let id: UUID
    let type: NotificationType
    let gameID: UUID
    let matchID: UUID
    let forPlayerID: UUID
    let creationTime: Date
}
