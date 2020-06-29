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
    @IBOutlet var convertedCurrencyLabel: MarginLabel!
    
    static var imageCurrencyToConvert = UIImage(named: "USD")
    static var imageConvertedCurrency = UIImage(named: "RUB")
    
    static var baseCurrency = "USD"
    static var toConvertCurrency = "RUB"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        convertButton.layer.cornerRadius = 13.0
        
        self.hideKeyboard()
        
        currencyToConvertButton.setImage(ViewController.imageCurrencyToConvert, for: .normal)
        convertedCurrencyButton.setImage(ViewController.imageConvertedCurrency, for: .normal)
        
        currencyToConvertTextFieled.backgroundColor = view.backgroundColor
        
        currencyToConvertTextFieled.layer.borderWidth = 1
        currencyToConvertTextFieled.layer.borderColor = UIColor.lightGray.cgColor
        currencyToConvertTextFieled.layer.cornerRadius = 5
        currencyToConvertTextFieled.adjustsFontSizeToFitWidth = true

        convertedCurrencyLabel.layer.borderWidth = 1
        convertedCurrencyLabel.layer.borderColor = UIColor.lightGray.cgColor
        convertedCurrencyLabel.layer.cornerRadius = 5
        
        currencyToConvertButton.layer.borderWidth = 1.3
        currencyToConvertButton.layer.borderColor = UIColor(ciColor: .white).cgColor
        currencyToConvertButton.layer.cornerRadius = 32
        
        convertedCurrencyButton.layer.borderWidth = 1.3
        convertedCurrencyButton.layer.borderColor = UIColor(ciColor: .white).cgColor
        convertedCurrencyButton.layer.cornerRadius = 32
    }
    
    override func viewDidLayoutSubviews() {
        currencyToConvertTextFieled.font = convertedCurrencyLabel.font
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.7) {
            self.convertButton.transform = CGAffineTransform.init(scaleX: 1.7, y: 1.7)
            self.convertButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
        self.getAndParse()
    }
    
    @IBAction func changeButtonTapped(_ sender: UIButton) {
        swap(&ViewController.imageCurrencyToConvert, &ViewController.imageConvertedCurrency)
        
        swap(&ViewController.baseCurrency, &ViewController.toConvertCurrency)
        
        currencyToConvertButton.setImage(ViewController.imageCurrencyToConvert, for: .normal)
        convertedCurrencyButton.setImage(ViewController.imageConvertedCurrency, for: .normal)
        
        guard Double(currencyToConvertTextFieled.text!) != nil else { convertedCurrencyLabel.text = "0.0"
            return
        }
        
        getAndParse()
    }
    
    func getAndParse() {
        guard let fieldValue = Double(currencyToConvertTextFieled.text!) else {
            showValueError()
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let url = URL(string: "https://api.exchangeratesapi.io/latest?base=\(ViewController.baseCurrency)&symbols=\(ViewController.self.toConvertCurrency)")!
            
            if let data = try? Data(contentsOf: url) {
                let jsonDecoder = JSONDecoder()
                if let cur = try? jsonDecoder.decode(Currency.self, from: data) {
                    if let valueToConvert = cur.rates[ViewController.toConvertCurrency] {
                        let total = valueToConvert * fieldValue
                        DispatchQueue.main.async {
                            self.convertedCurrencyLabel.text = String(format: "%.2f", total) + " " + ViewController.toConvertCurrency
                        }
                        return
                    }
                }
            }
            self.showConnectionError()
        }
    }
    
    func showValueError() {
        let ac = UIAlertController(title: "Incorrect value", message: "Please, enter correct number", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Accept", style: .default, handler: nil))
        convertedCurrencyLabel.text = "0.0"
        present(ac, animated: true)
    }
    
    func showConnectionError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Connection error", message: "Couldn't load data from server. Please, check your connection", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.convertedCurrencyLabel.text = "0.0"
            self.present(ac, animated: true)
        }
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
        
        guard Double(currencyToConvertTextFieled.text!) != nil else { convertedCurrencyLabel.text = "0.0"
            return
        }
        getAndParse()
    }
}
