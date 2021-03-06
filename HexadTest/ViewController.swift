//
//  ViewController.swift
//  HexadTest
//
//  Created by Anand, Walvekar on 1/27/19.
//  Copyright © 2019 Anand, Walvekar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var viewModel = ItemListViewModel()        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.viewModel.refresh {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.viewModel.items.count
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCellId") else {
            fatalError("Cell with identifier itemCellId not found")
        }
        let item = self.viewModel.items[indexPath.row]
        cell.textLabel?.text = item.itemName
        cell.detailTextLabel?.text = "\(Float(item.totalRating)/Float(item.ratingCount))"
        return cell
    }    
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section \(indexPath.section), row : \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func sort(_ button: UIBarButtonItem) {
        print("sort")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popoverContent = storyboard.instantiateViewController(withIdentifier: "PopoverViewControllerID") as! PopoverViewController
        popoverContent.callback = {(_ sort:Sort) in
            print("\(sort)")
            popoverContent.dismiss(animated: true, completion: nil)
            self.viewModel.sort(sort)
            self.tableView.reloadData()
        }
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = .popover
        let popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSize(width: 300, height: 400)
        popover?.sourceView = self.view
        popover?.sourceRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        self.present(nav, animated: true, completion: nil)
    }    
    
    @IBAction func randomRating(_ button: UIBarButtonItem) {
        if button.tag == 0 {
            print("started")
            button.title = "Stop"
            button.tag = 1
            self.viewModel.start()
        } else {
            print("stopped")
            button.title = "Start"
            button.tag = 0
            self.viewModel.stop()
            self.tableView.reloadData()
        }
    }
}
