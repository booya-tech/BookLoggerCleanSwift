//
//  AddBookPresenter.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/7/25.
//

import Foundation

class AddBookPresenter: AddBookPresentationLogic {
    // VIP Components
    weak var viewController: AddBookDisplayLogic?

    func presentBookCreationResult(response: AddBook.CreateBook.Response) {
        let message: String

        if response.success {
            if let book = response.book {
            message = "\(book.title) has been added to your library."
            } else {
                message = "Book added successfully"
            }
        } else {
            message = response.errorMessage ?? "Failed to add book. Please try again."
        }

        let viewModel = AddBook.CreateBook.ViewModel(success: response.success, message: message)

        viewController?.displayBookCreationResult(viewModel: viewModel)
    }

    func presentValidationResult(response: AddBook.ValidateInput.Response) {
        let viewModel = AddBook.ValidateInput.ViewModel(isValid: response.isValid, errorMessage: response.errorMessage)

        viewController?.displayValidationResult(viewModel: viewModel)
    }
}