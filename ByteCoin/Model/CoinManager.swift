//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, coinModel: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "ACFB6EA7-A213-47E2-A1EF-C47CF954D20E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
//                    var backToString = String(data: safeData, encoding: String.Encoding.utf8) as String?
//                    print(backToString)
                    if let coinModel = self.parseJSON(safeData) {
                        self.delegate?.didUpdatePrice(self, coinModel: coinModel)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let lastPrice = decodedData.rate
            print("lastPrice \(lastPrice)")
            let currency = decodedData.asset_id_quote
            print("currency \(currency)")
            
            let coinModel = CoinModel(currency: currency, rate: lastPrice)
            return coinModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}
