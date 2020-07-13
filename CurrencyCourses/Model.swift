//
//  Model.swift
//  CurrencyCourses
//
//  Created by Aleksey Lavrukhin on 25.06.2020.
//  Copyright © 2020 Aleksey Lavrukhin. All rights reserved.
//

import UIKit

class Currency {
    var txtName: String?        // txt
    var charCode: String?       // cc
    var rate: String?           // rate
    var rateDouble: Double?     // rate
    var imageFlag: UIImage? {
        if let charCode = charCode {
            return UIImage(named: charCode)
        }
        return nil
    }
    
    class func uah() -> Currency {
        let uah = Currency()
        uah.txtName = "Гривня"
        uah.rate = "1"
        uah.rateDouble = 1
        uah.charCode = "UAH"
        
        return uah
    }
}

class Model: NSObject {
    static let shared = Model()
    let path = NSSearchPathForDirectoriesInDomains(
                FileManager.SearchPathDirectory.libraryDirectory,
                FileManager.SearchPathDomainMask.userDomainMask,
                true)[0]+"/exchange.xml"
    
    var fromCurrency: Currency = Currency.uah()
    var toCurrency: Currency = Currency.uah()
    var currencies: [Currency] = []
    var currentCurrency: Currency?
    var currentCharacters: String = ""
    
    var pathToXML: String {
        if FileManager.default.fileExists(atPath: path) {
            return path
        }
        
        return Bundle.main.path(forResource: "exchange", ofType: "xml") ?? ""
    }
    var urlToXML: URL {
        return URL(fileURLWithPath: path)
    }
    
    func convert(amount: Double?) -> String {
        if amount != nil {
            let k = (fromCurrency.rateDouble! / toCurrency.rateDouble!) * amount!
            return String(k)
        } else {
            return ""
        }
    }
    
    // load XML from bank.gov.ua and save it to app catalog
    func loadXMLFile(date: Date?) {
        var strUrl = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?date="
        
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            strUrl = strUrl+dateFormatter.string(from: date!)
        }
        
        let url = URL(string: strUrl)
        let task = URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            if error == nil {
                
                do {
                    try data?.write(to: self.urlToXML) //URL(fileURLWithPath: self.path))
                    self.parseXMLFile()
                } catch {
                    print("Error when save data: \(error.localizedDescription)")
                }
            } else {
                print("Error when loadXMLFile: \(error!.localizedDescription)")
            }
            
        }
        
        task.resume()
    }
    
    
    func parseXMLFile() {
        currencies = [Currency.uah()]
        let parser = XMLParser(contentsOf: urlToXML)
        parser?.delegate = self
        parser?.parse()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataUpdated"), object: self)
    }
}

extension Model: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "currency" {
            currentCurrency = Currency()
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentCharacters = string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "txt":
            currentCurrency?.txtName = currentCharacters
        case "rate":
            currentCurrency?.rate = currentCharacters
            currentCurrency?.rateDouble = Double(currentCharacters)
        case "cc":
            currentCurrency?.charCode = currentCharacters
        case "currency":
            currencies.append(currentCurrency!)
        default:
            break
        }
    }
}
