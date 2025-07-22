//
//  EarningsModel.swift
//  WithEdge
//
//  Created by Max zam on 19/07/2025.
//

struct StockEarnings: Codable, Hashable {
    static func == (lhs: StockEarnings, rhs: StockEarnings) -> Bool {
        lhs.stock == rhs.stock
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(stock)
            hasher.combine(date)
        }
    
    let stock: Stock
    let reported: Double
    let estimate: Double
    let date: String
    
    var surprise: Double {
        reported - estimate
    }
    var surprisePercentage: Double {
        (reported - estimate) / estimate * 100
    }
}
