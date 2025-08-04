//
//  BookListProtocols.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/3/25.
//

import Foundation

protocol BookListBusinessLogic {
    func loadBooks(request: BookList.LoadBooks.Request)
}

protocol BookListPresentationLogic {
    func presentBooks(response: BookList.LoadBooks.Response)
}

protocol BookListDisplayLogic: AnyObject {
    func displayBooks(viewModel: BookList.LoadBooks.ViewModel)
}

protocol BookListRoutingLogic {
    func routeToAddBook()
}

protocol BookListDataPassing {
    var dataStore: BookListDataStore? { get}
}

protocol BookListDataStore {
    var books: [Book] { get set }
}
		
