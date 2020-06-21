//
//  ViewController.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 11.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController {
    @IBOutlet var convertButton: UIButton!
    
    @IBOutlet var currencyToConvertButton: UIButton!
    @IBOutlet var convertedCurrencyButton: UIButton!
    
    @IBOutlet var currencyToConvertTextFieled: UITextField!
    @IBOutlet var convertedCurrencyLabel: UILabel!
    
    static var imageCurrencyToConvert = UIImage(named: "USD")
    static var imageConvertedCurrency = UIImage(named: "RUB")
    
    static var baseCurrency = "USD"
    static var toConvertCurrency = "RUB"
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.7) {
            self.convertButton.transform = CGAffineTransform.init(scaleX: 1.7, y: 1.7)
            self.convertButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
            self.makeRequest()
        }
    }
    
    func addToHistory() {
        let doubleCurrencyValue = String(Double(self.currencyToConvertTextFieled.text!)!) + " " + ViewController.baseCurrency
        let convertion = Convertion(currencyToConvertImage: ViewController.imageCurrencyToConvert!, convertedCurrencyImage: ViewController.imageConvertedCurrency!,
                                    toConvertValue: doubleCurrencyValue,
                                    convertedValue: self.convertedCurrencyLabel.text!)
        
        HistoryTableViewController.histories.append(convertion)
        HistoryTableViewController.histories = HistoryTableViewController.histories.reversed()
    }
    
    @IBAction func changeButtonTapped(_ sender: UIButton) {
        swap(&ViewController.imageCurrencyToConvert, &ViewController.imageConvertedCurrency)
        
        swap(&ViewController.baseCurrency, &ViewController.toConvertCurrency)
        
        currencyToConvertButton.setImage(ViewController.imageCurrencyToConvert, for: .normal)
        convertedCurrencyButton.setImage(ViewController.imageConvertedCurrency, for: .normal)
        
        makeRequest()
    }
    
    func makeRequest() {
        let baseURL = URL(string: "https://api.exchangeratesapi.io/latest?base=\(ViewController.baseCurrency)&symbols=\(ViewController.self.toConvertCurrency)")!
        
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                if let dictionary = json as? [String: Any],
                    let convCurrency = dictionary["rates"] {
                    let conv = (convCurrency as? [String: Any])![ViewController.self.toConvertCurrency] as! Double
                    DispatchQueue.main.async {
                        if let currentValue = Double(self.currencyToConvertTextFieled.text!) {
                            let total = currentValue * conv
                            self.convertedCurrencyLabel.text = String(format: "%.2f", total) + " " + ViewController.toConvertCurrency
                            self.addToHistory()
                        } else {
                            self.convertedCurrencyLabel.text = String(0)
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        convertButton.layer.cornerRadius = 13.0
        
        self.hideKeyboard()
        
        currencyToConvertButton.setImage(ViewController.imageCurrencyToConvert, for: .normal)
        convertedCurrencyButton.setImage(ViewController.imageConvertedCurrency, for: .normal)
        
        
        currencyToConvertTextFieled.layer.borderWidth = 1
        currencyToConvertTextFieled.layer.borderColor = UIColor.lightGray.cgColor
        currencyToConvertTextFieled.layer.cornerRadius = 20
        
        convertedCurrencyLabel.layer.borderWidth = 1
        convertedCurrencyLabel.layer.borderColor = UIColor.lightGray.cgColor
        convertedCurrencyLabel.layer.cornerRadius = 20
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "currentCurrencySegue" {
            let curTable = segue.destination as! CurrenciesTableViewController
            curTable.forConverting = true
        }
        else if segue.identifier == "convertedCurrencySegue" {
            let curTable = segue.destination as! CurrenciesTableViewController
            curTable.forResult = true
        }
    }
    
    @IBAction func undwindToCurList(segue: UIStoryboardSegue) {
        currencyToConvertButton.setImage(ViewController.imageCurrencyToConvert, for: .normal)
        convertedCurrencyButton.setImage(ViewController.imageConvertedCurrency, for: .normal)
        
        makeRequest()
    }
    
    @IBAction func unwindAndClear(segue: UIStoryboardSegue) {
        HistoryTableViewController.histories.removeAll()
    }
}

