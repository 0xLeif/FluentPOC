//
//  ViewController.swift
//  FluentPOC
//
//  Created by CRi on 2/27/20.
//  Copyright © 2020 ol. All rights reserved.
//

import UIKit
import FluentSQLite
import SwiftUIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.embed {
            Table {
                [
                    Button("Prepare") {
                        print("Preparing...")
                        AppDelegate.db.pool.requestConnection().whenSuccess { (connection) in
                            Todo.prepare(on: connection).whenComplete {
                                print("Prepared!")
                            }
                        }
                    },
                    Button("Create") {
                        print("Creating...")
                        AppDelegate.db.pool.requestConnection().whenSuccess { (connection) in
                            Todo(title: "Hello World! \(Int.random(in: 0 ... 100))").save(on: connection).whenComplete {
                                print("Created!")
                            }
                        }
                    },
                    Button("Fetch") {
                        print("Fetching...")
                        AppDelegate.db.pool.requestConnection().whenSuccess { (connection) in
                            Todo.query(on: connection).all().whenSuccess { (todos) in
                                print("Fetched!")
                                print(todos.map { $0.title })
                            }
                        }
                    }
                ]
            }
        }
        
    }
}


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
