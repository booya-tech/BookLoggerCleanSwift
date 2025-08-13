//
//  BookListModels.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/3/25.
//

import Foundation

enum BookList {
    enum LoadBooks {
        struct Request {
            let statusFilter: BookStatus?
        }

        struct Response {
            let books: [Book]
        }

        struct ViewModel {
            let displayBooks: [DisplayedBook]
        }

        struct DisplayedBook {
            let id: String
            let title: String
            let author: String
            let statusText: String
            let statusEmoji: String
        }
    }

    enum UpdateStatus {
        struct Request {
            let bookId: String
            let newStatus: BookStatus
        }

        struct Response {
            let updated: Bool
            let books: [Book]
        }

        struct ViewModel {
            let displayedBooks: [LoadBooks.DisplayedBook]
        }
    }
}