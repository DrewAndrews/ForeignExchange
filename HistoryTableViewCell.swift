//
//  HistoryTableViewCell.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 17.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet var currencyToConvertImage: UIImageView!
    @IBOutlet var convertedCurrencyImage: UIImageView!
    @IBOutlet var currencyToConvertValue: UILabel!
    @IBOutlet var convertedCurrencyLabel: UILabel!
    
    func update(with convertion: Convertion) {
        currencyToConvertImage.image = convertion.currencyToConvertImage
        convertedCurrencyImage.image = convertion.convertedCurrencyImage
        currencyToConvertValue.text = convertion.toConvertValue
        convertedCurrencyLabel.text = convertion.convertedValue
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
