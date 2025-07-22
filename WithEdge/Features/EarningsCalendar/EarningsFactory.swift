//
//  EarningsFactory.swift
//  WithEdge
//
//  Created by Max zam on 20/07/2025.
//

protocol EarningsCalendarFactory {
    func makeViewModel() -> EarningsViewModel
    func makeViewController() -> EarningsCalendarViewController
}

struct EarningsCalendarFactoryImpl: EarningsCalendarFactory {
    private var apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func makeViewModel() -> EarningsViewModel {
        EarningsViewModel(apiService: apiService)
    }
    
    func makeViewController() -> EarningsCalendarViewController {
        EarningsCalendarViewController(viewModel: makeViewModel())
    }
}



