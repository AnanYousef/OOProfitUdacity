//
//  TableViewController.swift
//  OOProfitFinal
//
//  Created by Anan Yousef on 21/03/2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var profits: [Profit]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profits = UserDefaulsManager.shared.getProfits()
        
        self.tableView.reloadData()
    }
    
    

    // MARK: - Table view data source

    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.profits.count
    }
    
   

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        DispatchQueue.main.async {

            self.tableView.reloadData()
        }
        
        cell.LoadPays.text = "Load Pay"
        cell.Profit.text = "Profit"
        
        
        
 
        let profit = self.profits[indexPath.row]
        
        cell.LoadPaysMoney.text = profit.loadPay.description
        cell.ProfitMoney.text = profit.profit.description
        

        return cell
    }
}

