//
//  AddBookProtocols.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/5/25.
//

import Foundation

// Business Logic Protocol
// Interactor must handle book creation and validation
protocol AddBookBusinessLogic {
    func createBook(request: AddBook.CreateBook.Request)
    func validateInput(request: AddBook.ValidateInput.Request)
}

// Presentation Logic Protocol
// Presenter must format success/error messages
protocol AddBookPresentationLogic {
    func presentBookCreationResult(response: AddBook.CreateBook.Response)
    func presentValidationResult(response: AddBook.ValidateInput.Response)
}

// Display Logic Protocol
// ViewController must show results and validation feedback
protocol AddBookDisplayLogic: AnyObject {
    func displayBookCreationResult(viewModel: AddBook.CreateBook.ViewModel)
    func displayValidationResult(viewModel: AddBook.ValidateInput.ViewModel)
}

// Routing Logic Protocol
// Router must handle navigation to book list
protocol AddBookRoutingLogic {
    func routeBackToBookList()
}

// Data Passing Protocol
protocol AddBookDataPassing {
    var dataStore: AddBookDataStore? { get}
}

// Data Store Protocol
// Store the newly created book for passing between scenes
protocol AddBookDataStore {
    var newBook: Book? { get set }
}