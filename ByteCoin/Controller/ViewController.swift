//
//  ViewController.swift
//  ByteCoin
//
//  Created by Bryant Irawan on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {
    
    var coinManager = CoinManager()

    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var bitcoinLabel: UILabel!
    @IBOutlet var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
}

//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(_ coinManager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            print("from VC")
            print(coinModel.rate)
            print(coinModel.currency)
            self.bitcoinLabel.text = String(coinModel.rate)
            self.currencyLabel.text = coinModel.currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
