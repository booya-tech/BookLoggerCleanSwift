//
//  BookCell.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/3/25.
//

import UIKit

class BookCell: UITableViewCell {
    static let identifier = "BookCell"
    
    private let statusEmojiLabel = UILabel()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let statusLabel = UILabel()
    private let stackView = UIStackView()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Configure status emoji label
        statusEmojiLabel.font = UIFont.systemFont(ofSize: 24)
        statusEmojiLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // Configure title label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        
        // Configure author label
        authorLabel.font = UIFont.systemFont(ofSize: 14)
        authorLabel.textColor = .systemGray
        
        // Configure status label
        statusLabel.font = UIFont.systemFont(ofSize: 12)
        statusLabel.textColor = .systemBlue
        statusLabel.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        statusLabel.layer.cornerRadius = 4
        statusLabel.clipsToBounds = true
        statusLabel.textAlignment = .center
        statusLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // Configure text stack view
        let textStackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel])
        textStackView.axis = .vertical
        textStackView.spacing = 4
        textStackView.alignment = .leading
        
        // Configure main stack view
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.addArrangedSubview(statusEmojiLabel)
        stackView.addArrangedSubview(textStackView)
        stackView.addArrangedSubview(statusLabel)
        
        // Add to content view
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    // MARK: - Configuration
    func configure(with book: BookList.LoadBooks.DisplayedBook) {
        statusEmojiLabel.text = book.statusEmoji
        titleLabel.text = book.title
        authorLabel.text = book.author
        statusLabel.text = book.statusText
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        statusEmojiLabel.text = nil
        titleLabel.text = nil
        authorLabel.text = nil
        statusLabel.text = nil
    }
}
