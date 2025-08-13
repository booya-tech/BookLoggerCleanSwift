//
//  Book.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/2/25.
//

import Foundation

struct Book: Codable {
    let id: String
    let title: String
    let author: String
    let status: BookStatus
    let dataAdded: Date
}

enum BookStatus: String, CaseIterable, Codable {
    case wantToRead = "Want to Read"
    case currentlyReading = "Currently Reading"
    case finishedReading = "Finished Reading"

    var emoji: String {
        switch self {
        case .wantToRead: return "📚"
        case .currentlyReading: return "📖"
        case .finishedReading: return "✅"
        }
    }
}