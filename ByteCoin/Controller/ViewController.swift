//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var coinManager = CoinManager()
    
    @IBOutlet weak var cryptoImg: UIImageView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var cryptoPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        cryptoPicker.dataSource = self
        cryptoPicker.delegate = self
        
        coinManager.delegate = self
        
        // Do any additional setup after loading the view.
    }


}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coin.currencyName
            self.rateLabel.text = coin.rateString
            self.cryptoImg.image = UIImage(systemName: coin.cryptoImg)
            
        }
        
    }
    
    func didFailedWithError(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
                return coinManager.currencyArray.count
            } else {
                return coinManager.cryptoArray.count
            }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
                return coinManager.currencyArray[row]
            } else {
                return coinManager.cryptoArray[row]
            }
        
    }
    
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedCurrency = coinManager.currencyArray[0]
        var selectedCrypto = coinManager.cryptoArray[0]
        
        if pickerView.tag == 1 {
            selectedCurrency = coinManager.currencyArray[row]
            
            print(coinManager.currencyArray[row])
        } else {
            selectedCrypto = coinManager.cryptoArray[row]
            print(coinManager.cryptoArray[row])
        }
        coinManager.getCoinPrice(for: selectedCrypto, currency: selectedCurrency)
    }
}
