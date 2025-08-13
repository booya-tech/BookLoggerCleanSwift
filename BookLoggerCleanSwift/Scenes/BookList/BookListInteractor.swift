//
//  BookListInteractor.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/3/25.
//

import Foundation

class BookListInteractor: BookListBusinessLogic, BookListDataStore {
    // VIP Components
    var presenter: BookListPresentationLogic?

    // Use storage; auto-save on mutation
    private let store: BookStoring

    var books: [Book] = []

    init(store: BookStoring = UserDefaultsBookStore()) {
        self.store = store
        let loaded = store.load()

        if loaded.isEmpty {
            loadSampleBooks()
            store.save(books)
        } else {
            books = loaded
        }
    }

    func loadBooks(request: BookList.LoadBooks.Request) {
        let result: [Book]

        if let filter = request.statusFilter {
            result = books.filter { $0.status == filter }
        } else {
            result = books
        }

        presenter?.presentBooks(response: .init(books: result))
    }

    func updateStatus(request: BookList.UpdateStatus.Request) {
        guard let index = books.firstIndex(where: { $0.id == request.bookId}) else {
            presenter?.presentUpdatedBooks(response: .init(updated: false, books: books))
            return
        }

        let old = books[index]
        books[index] = Book(id: old.id, title: old.title, author: old.author, status: request.newStatus, dataAdded: old.dataAdded)

        presenter?.presentUpdatedBooks(response: .init(updated: true, books: books))
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
