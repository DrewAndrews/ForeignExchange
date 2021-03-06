//
//  CurrenciesTableViewController.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 11.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import UIKit

class CurrenciesTableViewController: UITableViewController {
    let currencies = ["RUB", "USD", "CAD", "EUR", "CZK", "GBP", "ISK", "MXN", "RON", "HKD", "PLN", "KRW", "PHP", "DKK", "HUF", "SEK", "IDR", "INR", "BRL", "JPY", "THB", "CHF", "MYR", "BGN", "TRY", "CNY", "NOK", "NZD", "ZAR", "SGD", "AUD", "ILS"].sorted()
    
    var forConverting = false
    var forResult = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        configure(for: cell, indexPath: indexPath)
        return cell
    }
    
    func configure(for cell: UITableViewCell, indexPath: IndexPath) {
        cell.textLabel?.text = ""
        cell.detailTextLabel?.text = currencies[indexPath.row]
        cell.imageView?.layer.borderWidth = 1.3
        cell.imageView?.layer.borderColor = UIColor(ciColor: .white).cgColor
        cell.imageView?.layer.cornerRadius = 18
        cell.imageView?.image = UIImage(named: currencies[indexPath.row] + "_table")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = tableView.indexPathForSelectedRow!.row
        
        if segue.identifier == "returnToCurList" {
            if forConverting {
                if currencies[index] == ViewController.toConvertCurrency {
                    ViewController.imageConvertedCurrency = ViewController.imageCurrencyToConvert
                    ViewController.toConvertCurrency = ViewController.baseCurrency
                }
                ViewController.imageCurrencyToConvert = UIImage(named: currencies[index])!
                ViewController.baseCurrency = currencies[index]
                forConverting = false
            }
            else if forResult {
                if currencies[index] == ViewController.baseCurrency {
                    ViewController.imageCurrencyToConvert = ViewController.imageConvertedCurrency
                    ViewController.baseCurrency = ViewController.toConvertCurrency
                }
                ViewController.imageConvertedCurrency = UIImage(named: currencies[index])!
                ViewController.toConvertCurrency = currencies[index]
                forResult = false
            }
        }
    }
}

