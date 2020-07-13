//
//  SelectCurrencyController.swift
//  CurrencyCourses
//
//  Created by Aleksey Lavrukhin on 26.06.2020.
//  Copyright © 2020 Aleksey Lavrukhin. All rights reserved.
//

import UIKit

enum FlagCurrencySelecor {
    case from
    case to
}

class SelectCurrencyController: UITableViewController {
    var flagCurrency: FlagCurrencySelecor = .from
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.currencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        let selectedCurrency = Model.shared.currencies[indexPath.row]

        cell.textLabel?.text = selectedCurrency.txtName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency = Model.shared.currencies[indexPath.row]
        switch flagCurrency {
        case .from:
            Model.shared.fromCurrency = selectedCurrency
        case .to:
            Model.shared.toCurrency = selectedCurrency
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
