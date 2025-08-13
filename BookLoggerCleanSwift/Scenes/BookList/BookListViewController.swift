//
//  BookListViewController.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/2/25.
//

import UIKit

class BookListViewController: UIViewController {
    private let filterControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["All", "Want to Read", "Currently Reading", "Finished Reading"])
        control.selectedSegmentIndex = 0

        return control
    }()

    private var currentFilter: BookStatus? {
        switch filterControl.selectedSegmentIndex {
            case 1: return .wantToRead
            case 2: return .currentlyReading
            case 3: return .finishedReading
            default: return nil
        }
    }

    // MARK: - VIP Components
    var interactor: BookListBusinessLogic? // business logic
    var router: (NSObjectProtocol & BookListRoutingLogic & BookListDataPassing)? // navigation

    // Properties
    private let tableView = UITableView()
    private var displayedBooks: [BookList.LoadBooks.DisplayedBook] = []

    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupUI()
        loadBooks()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

        filterControl.addTarget(self, action: #selector(filterChanged), for:.valueChanged)
        let normalFont = UIFont.preferredFont(forTextStyle: .subheadline)
        let selectedFont = UIFont.preferredFont(forTextStyle: .subheadline).withWeight(.semibold)

        filterControl.setTitleTextAttributes([.font: normalFont], for: .normal)
        filterControl.setTitleTextAttributes([.font: selectedFont], for: .selected)

        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44 + 16))
        header.addSubview(filterControl)
        filterControl.translatesAutoresizingMaskIntoConstraints = false

        let filterControlConstraints = [
            filterControl.topAnchor.constraint(equalTo: header.topAnchor, constant: CGFloat(8)),
            filterControl.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: CGFloat(16)),
            filterControl.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: CGFloat(-16)),
            filterControl.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: CGFloat(-8))
        ]

        NSLayoutConstraint.activate(filterControlConstraints)
        tableView.tableHeaderView = header
    }

    private func loadBooks() {
        interactor?.loadBooks(request: .init(statusFilter: currentFilter))
    }

    @objc func filterChanged() {
        loadBooks()
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
    func displayUpdatedBooks(viewModel: BookList.UpdateStatus.ViewModel) {
        self.displayedBooks = viewModel.displayedBooks
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

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let model = displayedBooks[indexPath.row]

        let want = UIContextualAction(style: .normal, title: "Want") { [weak self] _, _, done in
            self?.interactor?.updateStatus(request: .init(bookId: model.id, newStatus: .wantToRead)); done(true)
        }

        let reading = UIContextualAction(style: .normal, title: "Reading") { [weak self] _, _, done in
            self?.interactor?.updateStatus(request: .init(bookId: model.id, newStatus: .currentlyReading)); done(true)
        }

        let finished = UIContextualAction(style: .normal, title: "Finished") { [weak self] _, _, done in
            self?.interactor?.updateStatus(request: .init(bookId: model.id, newStatus: .finishedReading)); done(true)
        }

        want.backgroundColor = .systemOrange
        reading.backgroundColor = .systemBlue
        finished.backgroundColor = .systemGreen

        return UISwipeActionsConfiguration(actions: [finished, reading, want])
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // will navigate to book details
    }
}
