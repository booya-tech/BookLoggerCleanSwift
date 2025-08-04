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
            BookList.LoadBooks.DisplayedBook(title: book.title, author: "by \(book.author)", statusText: book.status.rawValue, statusEmoji: book.status.emoji)
        }

        // 2. Create view model
        let viewModel = BookList.LoadBooks.ViewModel(displayBooks: displayedBooks)

        // Send formatted data to view controller
        viewController?.displayBooks(viewModel: viewModel)
    }
}