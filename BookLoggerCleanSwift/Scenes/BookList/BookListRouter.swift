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
        let destinationVC = AddBookViewController()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
