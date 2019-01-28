//
//  PopoverViewController.swift
//  HexadTest
//
//  Created by Anand, Walvekar on 1/28/19.
//  Copyright © 2019 Anand, Walvekar. All rights reserved.
//

import UIKit

class PopoverViewController: UITableViewController {
    
    var callback : ((_ sort:Sort) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "popOverCellId") else {
            fatalError("Cell with identifier itemCellId not found")
        }
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "by name"
        } else {
            cell.textLabel?.text = "by rating"
        }
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section \(indexPath.section), row : \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        self.callback?(Sort(rawValue: indexPath.row) ?? .name)
    }
}
