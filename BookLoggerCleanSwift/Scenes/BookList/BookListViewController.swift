//
//  BookListViewController.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/2/25.
//

import UIKit

class BookListViewController: UIViewController {
    // MARK: - Outlets
    private let tableView = UITableView()

    // MARK: - VIP Components
    var interactor: BookListBusinessLogic? // business logic
    var router: (NSObjectProtocol & BookListRoutingLogic & BookListDataPassing)? // navigation

    private var displayedBooks: [BookList.LoadBooks.DisplayedBook] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupUI()
        loadBooks()
    }

    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = BookListInteractor()
        let presenter = BookListPresenter()
        let router = BookListRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // Setup
    private func setupUI() {
        title = "My Books"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addBookTapped)
        )

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.identifier)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadBooks() {
        let request = BookList.LoadBooks.Request()
        interactor?.loadBooks(request: request)
    }

    @objc func addBookTapped() {
        router?.routeToAddBook()
    }
}

extension BookListViewController: BookListDisplayLogic {
    func displayBooks(viewModel: BookList.LoadBooks.ViewModel) {
        self.displayedBooks = viewModel.displayBooks
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else { return UITableViewCell() }
        let book = displayedBooks[indexPath.row]

        cell.configure(with: book)

        return cell
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // will navigate to book details
    }
}
