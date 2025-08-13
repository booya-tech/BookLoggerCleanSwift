//
//  AddBookInteractor.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/6/25.
//

import Foundation

class AddBookInteractor: AddBookBusinessLogic, AddBookDataStore {
    // VIP componentss
    var presenter: AddBookPresentationLogic?

    // Data Store
    var newBook: Book?

    // Business Logic
    func createBook(request: AddBook.CreateBook.Request) {
        // Validate input first
        let validationRequest = AddBook.ValidateInput.Request(title: request.title, author: request.author)

        validateInput(request: validationRequest)

        // Check if validation passed
        guard !request.title.isEmpty && !request.author.isEmpty else {
            let response = AddBook.CreateBook.Response(success: false, book: nil, errorMessage: "Please fill in all fields")

            presenter?.presentBookCreationResult(response: response)
            
            return
        }

        // Create new book
        let book = Book(
            id: UUID().uuidString,
            title: request.title.trimmingCharacters(in: .whitespacesAndNewlines), 
            author: request.author.trimmingCharacters(in: .whitespacesAndNewlines),
            status: request.status,
            dataAdded: Date()
        )

        // Store in data store for passing to other scenes
        newBook = book

        // Create success response
        let response = AddBook.CreateBook.Response(
            success: true,
            book: newBook,
            errorMessage: nil
        )

        presenter?.presentBookCreationResult(response: response)
    }

    func validateInput(request: AddBook.ValidateInput.Request) {
        let title = request.title.trimmingCharacters(in: .whitespacesAndNewlines)
        let author = request.author.trimmingCharacters(in: .whitespacesAndNewlines)

        var errorMessage: String?

        if title.isEmpty && author.isEmpty {
            errorMessage = "Title and Author are required"
        } else if title.isEmpty {
            errorMessage = "Title is required"
        } else if author.isEmpty {
            errorMessage = "Author is required"
        } else if title.count < 2 {
            errorMessage = "Title must be at least 2 characters"
        } else if author.count < 2 {
            errorMessage = "Author must be at least 2 characters"
        }

        let response = AddBook.ValidateInput.Response(isValid: errorMessage == nil, errorMessage: errorMessage)

        presenter?.presentValidationResult(response: response)
    }
}
