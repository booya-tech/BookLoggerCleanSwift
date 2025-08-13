//
//  BookListProtocols.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/3/25.
//

import Foundation

protocol BookListBusinessLogic {
    func loadBooks(request: BookList.LoadBooks.Request)
    func updateStatus(request: BookList.UpdateStatus.Request)
}

protocol BookListPresentationLogic {
    func presentBooks(response: BookList.LoadBooks.Response)
    func presentUpdatedBooks(response: BookList.UpdateStatus.Response)
}

protocol BookListDisplayLogic: AnyObject {
    func displayBooks(viewModel: BookList.LoadBooks.ViewModel)
    func displayUpdatedBooks(viewModel: BookList.UpdateStatus.ViewModel)
}

protocol BookListRoutingLogic {
    func routeToAddBook()
}

protocol BookListDataPassing {
    var dataStore: BookListDataStore? { get set }
}

protocol BookListDataStore {
    var books: [Book] { get set }
}
		
