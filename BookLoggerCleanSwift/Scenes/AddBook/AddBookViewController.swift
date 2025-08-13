//
//  AddBookViewController.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/9/25.
//

import UIKit

final class AddBookViewController: UIViewController, AddBookDisplayLogic {
    // VIP Components
    var interactor: AddBookBusinessLogic?
    var router: (NSObjectProtocol & AddBookRoutingLogic & AddBookDataPassing)?

    // Properties
    private let titleField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .words

        return textField
    }()

    private let authorField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Author"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .words

        return textField
    }()

    private let statusControl: UISegmentedControl = {
        let control = UISegmentedControl(items: BookStatus.allCases.map { $0.rawValue })
        control.selectedSegmentIndex = 0

        return control
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.isHidden = true

        return label
    }()

    private lazy var saveBarButton = UIBarButtonItem(
        title: "Save",
        style: .done,
        target: self,
        action: #selector(saveTapped)
    )

    private let stack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupUI()
    }

    private func setup() {
        let viewController = self
        let interactor = AddBookInteractor()
        let presenter = AddBookPresenter()
        let router = AddBookRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func setupUI() {
        title = "Add Book"
        view.backgroundColor = .systemBackground
        saveBarButton.isEnabled = false
        navigationItem.rightBarButtonItem = saveBarButton

        // Stack
        stack.axis = .vertical
        stack.spacing = 12
        [titleField, authorField, statusControl, errorLabel].forEach { stack.addArrangedSubview($0) }

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        let stackConstraints = [
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(stackConstraints)

        // Actions
        titleField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        authorField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    @objc private func textDidChange() {
        interactor?.validateInput(request: .init(title: titleField.text ?? "", author: authorField.text ?? ""))
    }

    @objc private func saveTapped() {
        let status = BookStatus.allCases[statusControl.selectedSegmentIndex]

        interactor?.createBook(request: .init(title: titleField.text ?? "", author: authorField.text ?? "", status: status))
    }
    
    func displayBookCreationResult(viewModel: AddBook.CreateBook.ViewModel) {
        if viewModel.success {
            router?.routeBackToBookList()
        } else {
            let alert = UIAlertController(title: "Error", message: viewModel.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    func displayValidationResult(viewModel: AddBook.ValidateInput.ViewModel) {
        errorLabel.text = viewModel.errorMessage
        errorLabel.isHidden = (viewModel.errorMessage == nil)
        saveBarButton.isEnabled = viewModel.isValid
    }
}
