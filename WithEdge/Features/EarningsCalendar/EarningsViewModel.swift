//
//  EarningsViewModel.swift
//  WithEdge
//
//  Created by Max zam on 20/07/2025.
//
import UIKit

class EarningsViewModel: ObservableObject {
    let apiService: ApiService
    
    @Published var earnings: [StockEarnings] = []
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchEarnings() async {
        guard let url = URL(string: "https://api.withedge.com/v1/earnings") else {
            print(#function, "Invalid URL")
            return
        }
        do {
            let result: [StockEarnings] = try await apiService.fetch(from: url)
            earnings = result
        } catch {
            print(#function, "Failed to fetch earnings: \(error)")
        }
    }
}
