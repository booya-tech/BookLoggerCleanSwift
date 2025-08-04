//
//  BookListInteractor.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/3/25.
//

import Foundation

class BookListInteractor: BookListBusinessLogic, BookListDataStore {
    var presenter: BookListPresentationLogic?

    var books: [Book] = []

    init() {
        loadSampleBooks()
    }

    func loadBooks(request: BookList.LoadBooks.Request) {
        // 1. Get books from data store
        let currentBooks = books

        // 2. Create response with raw data
        let response = BookList.LoadBooks.Response(books: currentBooks)

        // 3. Send to presenter for formatting
        presenter?.presentBooks(response: response)
    }

    // Mock Book Data
    private func loadSampleBooks() {
        books = [
            Book(id: "1", title: "Clean Code Swift", author: "Robert C. Martin", status: .finishedReading, dataAdded: Date()),
            Book(id: "2", title: "iOS Develoment with Swift", author: "Apple Inc.", status: .currentlyReading, dataAdded: Date()),
            Book(id: "3", title: "Design Patterns", author: "Gang of Four", status: .wantToRead, dataAdded: Date())
        ]
    }
}
