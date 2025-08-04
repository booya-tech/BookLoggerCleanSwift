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
            // Empty for now - could add filtering later
        }

        struct Response {
            let books: [Book]
        }

        struct ViewModel {
            let displayBooks: [DisplayedBook]
        }

        struct DisplayedBook {
            let title: String
            let author: String
            let statusText: String
            let statusEmoji: String
        }
    }
}