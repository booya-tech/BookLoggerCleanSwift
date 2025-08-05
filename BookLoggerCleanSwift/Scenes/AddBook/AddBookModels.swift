//
//  AddBookModels.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/5/25.
//

import Foundation

enum AddBook {
    // Add Book Use Case
    enum CreateBook {
        struct Request {
            let title: String
            let author: String
            let status: BookStatus
        }

        struct Response {
            let success: Bool
            let book: Book?
            let errorMessage: String?
        }

        struct ViewModel {
            let success: Bool
            let message: String
        }
    }

    enum ValidateInput {
        struct Request {
            let title: String
            let author: String
        }

        struct Response {
            let isValid: Bool
            let errorMessage: String?
        }

        struct ViewModel {
            let isValid: Bool
            let errorMessage: String?
        }
    }
}