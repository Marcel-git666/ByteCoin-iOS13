//
//  CoinData.swift
//  ByteCoin
//
//  Created by Marcel Mravec on 29.12.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation


struct CoinData: Decodable {
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
}
