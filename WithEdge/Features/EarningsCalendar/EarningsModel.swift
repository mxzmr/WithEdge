//
//  EarningsModel.swift
//  WithEdge
//
//  Created by Max zam on 19/07/2025.
//

struct StockEarning: Codable {
    let stock: Stock
    let reported: Double
    let estimate: Double
    
    var surprise: Double {
        reported - estimate
    }
    var surprisePercentage: Double {
        (reported - estimate) / estimate * 100
    }
}
