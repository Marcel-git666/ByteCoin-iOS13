//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailedWithError(error: Error)
}


struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "82C977C2-75C4-49CE-AB6B-63C0204B9536"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","CZK", "EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailedWithError(error: error!)
                    
                    return
                }
                if let safeData = data {
                    
                    if let coin = parseJSON(safeData) {
                        delegate?.didUpdateCoin(self, coin: coin)
                    }
                    
                
//                    var stringData = String(data: safeData, encoding: String.Encoding.utf8) as String?
//                    print(stringData)
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        do {
            let decodedData = try JSONDecoder().decode(CoinData.self, from: coinData)
            
        
            let cryptoName = decodedData.asset_id_base
            let currencyName = decodedData.asset_id_quote
            let rate = decodedData.rate
            
            let coin = CoinModel(cryptoName: cryptoName, currencyName: currencyName, rate: rate)
            return coin
            
            
        } catch {
            delegate?.didFailedWithError(error: error)
            return nil
            
        }
        
    }
    
}
