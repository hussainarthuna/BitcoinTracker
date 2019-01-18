//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Hussain Arthun on 18/01/2019.
//  Copyright (c) 2019 Hussain Arthuna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["","AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbol = ["","$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        bitcoinPriceLabel.text = ""
       
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        print(currencyArray[row])
        
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        getBitCoinPriceData(url: finalURL, row: row)
        
    }
    
    

    
    
    
//    
//    //MARK: - Networking
//    /***************************************************************/
//    
    func getBitCoinPriceData(url: String, row : Int) {
        
        Alamofire.request(url, method: .get).responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got the BitcoinPrice data")
                    let bitcoinPriceJSON : JSON = JSON(response.result.value!)

                    self.updateBitcoinPriceData(json: bitcoinPriceJSON, row: row)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }
//
//    
//    
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateBitcoinPriceData(json : JSON, row : Int) {
        
        if let bitcoinPriceResult = json["open"]["hour"].double {
        
            bitcoinPriceLabel.text = "\(currencySymbol[row])\(bitcoinPriceResult)"
        
        }
        else{
            bitcoinPriceLabel.text = "Price Unavailable"
        }
        
    

    }


}

