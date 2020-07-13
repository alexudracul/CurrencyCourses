//
//  CurrenciesController.swift
//  CurrencyCourses
//
//  Created by Aleksey Lavrukhin on 26.06.2020.
//  Copyright © 2020 Aleksey Lavrukhin. All rights reserved.
//

import UIKit

class CurrenciesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed"), object: nil, queue: nil) {
            (notification) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        Model.shared.loadXMLFile(date: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.currencies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyCell
        let currencyForCell = Model.shared.currencies[indexPath.row]
        cell.initCell(currency: currencyForCell)
        return cell
    }
}
