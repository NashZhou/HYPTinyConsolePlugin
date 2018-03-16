//
//  DemoController.swift
//  TinyConsoleSwiftDemo
//
//  Created by Nash Zhou on 3/5/18.
//  Copyright © 2018 nashzhou. All rights reserved.
//

import Foundation
import UIKit

import TinyConsolePlugin.TinyConsole

class DemoController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TinyConsole.printText("Tapped on \(indexPath.row)")
    }
    
}
