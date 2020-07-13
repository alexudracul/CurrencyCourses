//
//  ConverterController.swift
//  CurrencyCourses
//
//  Created by Aleksey Lavrukhin on 26.06.2020.
//  Copyright © 2020 Aleksey Lavrukhin. All rights reserved.
//

import UIKit

class ConverterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        textFrom.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshButtons()
        textFromEditingChange(self)
        navigationItem.rightBarButtonItem = nil
    }
    
    @IBOutlet weak var buttonFrom: UIButton!
    @IBOutlet weak var buttonTo: UIButton!
    @IBOutlet weak var buttonDone: UIBarButtonItem!
    @IBOutlet weak var textFrom: UITextField!
    @IBOutlet weak var textTo: UITextField!
    
    
    @IBAction func textFromEditingChange(_ sender: Any) {
        let amount = Double(textFrom.text!)
        textTo.text = Model.shared.convert(amount: amount)
    }
    
    @IBAction func pushFromAction(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        (nc.viewControllers[0] as! SelectCurrencyController).flagCurrency = .from
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true, completion: nil)
    }
    
    @IBAction func pushToAction(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        (nc.viewControllers[0] as! SelectCurrencyController).flagCurrency = .to
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true, completion: nil)
    }
    
    @IBAction func pushDoneAction(_ sender: Any) {
        textFrom.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
    }
    
    func refreshButtons() {
        buttonFrom.setTitle(Model.shared.fromCurrency.charCode, for: UIControl.State.normal)
        buttonTo.setTitle(Model.shared.toCurrency.charCode, for: UIControl.State.normal)
    }
    
}

extension ConverterController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        navigationItem.rightBarButtonItem = buttonDone
        return true
    }
}
