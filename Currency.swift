//
//  Currency.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 21.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import Foundation

struct Currency: Codable {
    var rates: [String: Double]
}
