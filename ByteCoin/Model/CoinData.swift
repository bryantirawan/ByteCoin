//
//  CoinData.swift
//  ByteCoin
//
//  Created by Bryant Irawan on 2/23/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let time: String
    let asset_id_base: String //BTC
    let asset_id_quote: String //USD
    let rate: Float
}
