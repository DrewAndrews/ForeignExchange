//
//  StocksTableViewController.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 18.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import UIKit

class StocksTableViewController: UITableViewController {
    
    let stocksAcromyns: [String] = ["AAPL", "TSLA", "FB", "YNDX", "BA", "AMZN", "MSFT", "UBER", "ORCL"]
    
    static var stocks: [Stock] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func makeRequest(for cell: UITableViewCell, with indexPath: IndexPath) {
        let baseURL = URL(string: "https://alpha-vantage.p.rapidapi.com/query?function=GLOBAL_QUOTE&symbol=\(stocksAcromyns[indexPath.row])")!
        
        let headers = ["x-rapidapi-host": "alpha-vantage.p.rapidapi.com",
                       "x-rapidapi-key": "c5feb12f82msh8582610f99e9066p13a296jsn36a2468f0f3e"]
        
        var request = URLRequest(url: baseURL)
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                let stockJson = json as! [String: Any]
                if let stockProperties = stockJson["Global Quote"] as? [String: Any] {
                    print(stockProperties)
                    let name = stockProperties["01. symbol"] as! String
                    let open = stockProperties["02. open"] as! String
                    let high = stockProperties["03. high"] as! String
                    let low = stockProperties["04. low"] as! String
                    let price = stockProperties["05. price"] as! String
                    let volume = stockProperties["06. volume"] as! String
                    let ltd = stockProperties["07. latest trading day"] as! String
                    let prevclose = stockProperties["08. previous close"] as! String
                    let change = stockProperties["09. change"] as! String
                    let chpercent = stockProperties["10. change percent"] as! String
                    
                    let stock = Stock(name: name, open: open, high: high, low: low, price: price, volume: volume, ltd: ltd, prevclose: prevclose, change: change, chpercent: chpercent)
                    StocksTableViewController.stocks.append(stock)
                    
                    DispatchQueue.main.async {
                        cell.textLabel?.text = stock.name
                        cell.detailTextLabel?.text = String(stock.price)
                    }
                }
            }
        }
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stocksAcromyns.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)

        makeRequest(for: cell, with: indexPath)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stockDetailSegue" {
            let dist = segue.destination as! StockDetailViewController
            let index = tableView.indexPathForSelectedRow?.row
            
            dist.forIndex = index!
        }
    }
}
