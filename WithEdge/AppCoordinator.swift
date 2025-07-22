//
//  AppCoordinator.swift
//  WithEdge
//
//  Created by Max zam on 19/07/2025.
//

class AppCoordinator: BaseCoordinator {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
        super.init()
    }
    
    override func start() {
    }
    
    private func showEarningsCalendar() {
        let factory = EarningsCalendarFactoryImpl(apiService: apiService)
        let viewController = factory.makeViewController()
        navigationController.setViewControllers([viewController], animated: false)
    }
}
