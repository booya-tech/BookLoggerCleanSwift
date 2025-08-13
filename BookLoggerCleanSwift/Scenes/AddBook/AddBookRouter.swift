//
//  AddBookRouter.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/9/25.
//

import UIKit

class AddBookRouter: NSObject, AddBookRoutingLogic, AddBookDataPassing {
    // VIP Components
    weak var viewController: AddBookViewController?
    var dataStore: (any AddBookDataStore)?

    func routeBackToBookList() {
        guard let nav = viewController?.navigationController,
              let source = dataStore,
              let newBook = source.newBook else { 
            viewController?.navigationController?.popViewController(animated: true)
            return
        }

        // Find BookList and append
        if let destinationVC = nav.viewControllers.reversed().first(where: { $0 is BookListViewController }) as? BookListViewController {
            destinationVC.router?.dataStore?.books.append(newBook)
            nav.popToViewController(destinationVC, animated: true)
        } else {
            nav.popViewController(animated: true)
        }
    }

    func passDataToBookList(source: AddBookDataStore, destination: inout BookListDataStore) {
        if let newBook = source.newBook {
            destination.books.append(newBook)
        }
    }
}
