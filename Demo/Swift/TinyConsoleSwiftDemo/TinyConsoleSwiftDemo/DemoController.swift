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

class DemoController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let btn = UIButton(type: .system)
        btn.setTitle("Click me", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnPressed(sender:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            btn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            btn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
    @objc func btnPressed(sender: UIButton!) {
        TinyConsole.printText("Hello Console")
    }
}
