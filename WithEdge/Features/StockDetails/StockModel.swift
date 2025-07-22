//
//  StockModel.swift
//  WithEdge
//
//  Created by Max zam on 19/07/2025.
//

struct Stock: Codable, Equatable, Hashable {
    let symbol: String
    let open: Double
    let close: Double
    let high: Double
    let low: Double
    let volume: Int
}
