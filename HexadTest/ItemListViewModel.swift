//
//  ItemListViewModel.swift
//  HexadTest
//
//  Created by Anand, Walvekar on 1/27/19.
//  Copyright © 2019 Anand, Walvekar. All rights reserved.
//

import Foundation

struct ItemsResponse:Codable {
    let items:[Item]
}

struct Item : Codable {
    let itemName:String
    let itemId:Int
    var ratingCount:Int = 0
    var totalRating:Int = 0
}

enum Sort:Int {
    case name, rating
}

protocol Refreshable {
    func refresh(_ callback: @escaping () -> Void)
}

class ItemListViewModel: Refreshable {
    private var callback:(() -> Void)?
    var items:[Item] = []
    var timer:Timer?
    
    func refresh(_ callback: @escaping () -> Void) {
        self.callback = callback
        
        if let path = Bundle.main.path(forResource: "Items", ofType: "json") {
            print("found")
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let object = try JSONDecoder().decode(ItemsResponse.self, from: data)
                self.items = object.items
                self.callback?()
            } catch let error as NSError {
                fatalError("\(error)")
            }
        }        
    }
    
    func sort(_ sort:Sort) {
        items.sort(by: { (item1, item2) -> Bool in
            let item1Rating = item1.totalRating/item1.ratingCount
            let item2Rating = item2.totalRating/item2.ratingCount
            
            if sort == Sort.rating {
                return item1Rating > item2Rating
            } else if sort == Sort.name {
                return item1.itemName < item2.itemName
            }
            return item1.itemId > item2.itemId
        })
    }
    
    func start() {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (_) in
                let index = Int.random(in: 0..<self.items.count)
                let rating = Int.random(in: 1...5)
                self.items[index].totalRating += rating
                self.items[index].ratingCount += 1
                print("\(self.items[index].itemName), \(index), \(rating), \(self.items[index].ratingCount)")
            })
    }
    
    func stop() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
