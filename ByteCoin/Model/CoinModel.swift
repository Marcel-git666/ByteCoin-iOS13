//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Marcel Mravec on 29.12.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let cryptoName: String
    let currencyName: String
    let rate: Double
    var rateString: String {
        String(format: "%.2f", rate)
    }
    var cryptoImg: String {
        switch cryptoName {
        case "BTC": return "bitcoinsign.circle"
        case "ETH": return "e.circle"
        default: return "questionmark"
        }
    }

}
