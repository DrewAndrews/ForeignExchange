//
//  StockDetailViewController.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 18.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

    @IBOutlet var openValueLabel: UILabel!
    @IBOutlet var highValueLabel: UILabel!
    @IBOutlet var lowValueLabel: UILabel!
    
    var forIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let currentStock = StocksTableViewController.stocks[forIndex]
        
        title = currentStock.name
        openValueLabel.text = currentStock.open
        highValueLabel.text = currentStock.high
        lowValueLabel.text = currentStock.low
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
