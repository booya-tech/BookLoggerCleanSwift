//
//  BookListRouter.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/3/25.
//

import UIKit

class BookListRouter: NSObject, BookListRoutingLogic, BookListDataPassing {
    // VIP Components
    weak var viewController: BookListViewController?
    var dataStore: BookListDataStore?

    // Routing Logic
    func routeToAddBook() {
        // will AddBookViewController later
        let alert = UIAlertController(title: "Add Book", message: "This will navigate to Add Book screen", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        viewController?.present(alert, animated: true)
    }
}
