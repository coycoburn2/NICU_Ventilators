//
//  SearchResultsViewController.swift
//  NICU Ventilators
//
//  Created by Coy Coburn on 4/21/23.
//

import UIKit
import Foundation

class SearchResultsViewController: UITableViewController {
    var searchResults: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register a table view cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Set the cell text to the localized string key and value
        let localizedString = Array(searchResults)[indexPath.row]
        cell.textLabel?.text = "\(localizedString.key): \(localizedString.value)"
        
        return cell
    }
}
