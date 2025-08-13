//
//  BookListPresenter.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/3/25.
//

import Foundation

class BookListPresenter: BookListPresentationLogic {
    // VIP Components
    weak var viewController: BookListDisplayLogic?

    // Presentation Logic
    func presentBooks(response: BookList.LoadBooks.Response) {
        // Transform raw books into display-friendly format
        let displayedBooks = response.books.map { book in
            BookList.LoadBooks.DisplayedBook(id: book.id, title: book.title, author: "by \(book.author)", statusText: book.status.rawValue, statusEmoji: book.status.emoji)
        }

        // 2. Create view model
        let viewModel = BookList.LoadBooks.ViewModel(displayBooks: displayedBooks)

        // Send formatted data to view controller
        viewController?.displayBooks(viewModel: viewModel)
    }

    func presentUpdatedBooks(response: BookList.UpdateStatus.Response) {
        let displayed = mapToDisplayedBooks(response.books)

        viewController?.displayUpdatedBooks(viewModel: .init(displayedBooks: displayed))
    }

    private func mapToDisplayedBooks(_ books: [Book]) -> [BookList.LoadBooks.DisplayedBook] {
        return books.map {
            .init(id: $0.id, title: $0.title, author: $0.author, statusText: $0.status.rawValue, statusEmoji: $0.status.emoji)
        }
    }
}
