//
//  ViewController.swift
//  FluentPOC
//
//  Created by CRi on 2/27/20.
//  Copyright © 2020 ol. All rights reserved.
//

import UIKit
import FLite
import SwiftUIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.embed {
            Table {
                [
                    Button("Prepare") {
                        print("Preparing...")
                        FLite.prepare(model: Todo.self) {
                            print("Prepared!")
                        }
                    },
                    Button("Create") {
                        print("Creating...")
                        FLite.create(model: Todo(title: "Hello World! \(Int.random(in: 0 ... 100))")) {
                            print("Created!")
                        }
                    },
                    Button("Fetch") {
                        print("Fetching...")
                        FLite.fetch(model: Todo.self) { (values) in
                            print("Fetched!")
                            print(values.map { $0.title })
                        }
                    }
                ]
            }
        }
        
    }
}
