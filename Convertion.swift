//
//  Convertion.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 17.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import Foundation
import UIKit

class Convertion {
    var currencyToConvertImage: UIImage!
    var convertedCurrencyImage: UIImage!
    var toConvertValue: String
    var convertedValue: String
    
    init(currencyToConvertImage: UIImage, convertedCurrencyImage: UIImage, toConvertValue: String,
         convertedValue: String) {
        self.currencyToConvertImage = currencyToConvertImage
        self.convertedCurrencyImage = convertedCurrencyImage
        self.toConvertValue = toConvertValue
        self.convertedValue = convertedValue
    }
}
