//
//  Todo.swift
//  FluentPOC
//
//  Created by 0xLeif on 2/27/20.
//  Copyright © 2020 ol. All rights reserved.
//

import FluentSQLite

/// A single entry of a Todo list.
final class Todo: SQLiteModel {
    /// The unique identifier for this `Todo`.
    var id: Int?

    /// A title describing what this `Todo` entails.
    var title: String

    /// Creates a new `Todo`.
    init(id: Int? = nil, title: String) {
        self.id = id
        self.title = title
    }
}

/// Allows `Todo` to be used as a dynamic migration.
extension Todo: Migration { }
