//
//  Stock.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 18.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import Foundation

class Stock {
    var name: String
    var open: String
    var high: String
    var low: String
    var price: String
    var volume: String
    var ltd: String
    var prevclose: String
    var change: String
    var chpercent: String
    
    init(name: String, open: String, high: String, low: String, price: String, volume: String, ltd: String,
         prevclose: String, change: String, chpercent: String) {
        self.name = name
        self.open = open
        self.high = high
        self.low = low
        self.price = price
        self.volume = volume
        self.ltd = ltd
        self.prevclose = prevclose
        self.change = change
        self.chpercent = chpercent
    }
}
