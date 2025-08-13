//
//  BookStore.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/13/25.
//

import Foundation

protocol BookStoring {
    func load() -> [Book]
    func save(_ books: [Book])
}

final class UserDefaultsBookStore: BookStoring {
    private let key = "booklogger.books"

    func load() -> [Book] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([Book].self, from: data)) ?? []
    }

    func save(_ books: [Book]) {
        let data = try? JSONEncoder().encode(books)
        UserDefaults.standard.set(data, forKey: key)
    }
}
