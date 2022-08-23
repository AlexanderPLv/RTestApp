//
//  ModulesFactory.swift
//  RoxieTest
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import UIKit

protocol OnboardingBuilderProtocol {
    func buildOnboardingScreen() -> OnboardingScreen
}

protocol MainBuilderProtocol {
    func buildListScreen() -> ListScreen
    func buildDetailsScreen(order: OrderInfo) -> DetailsScreen
}

final class ModulesFactory {
   
    private let parser = Parser.shared
    private let requestFactory: RequestFactory
    private let networkManager: NetworkManager
    
    init() {
        self.requestFactory = RequestFactory.shared
        self.networkManager = NetworkManager.build(with: requestFactory)
    }
    
    class func build() -> ModulesFactory {
        let factory = ModulesFactory()
        return factory
    }
}

extension ModulesFactory: OnboardingBuilderProtocol {
    
    func buildOnboardingScreen() -> OnboardingScreen {
        let controller = OnboardingScreen(dataProvider: networkManager)
        return controller
    }
    
}

extension ModulesFactory: MainBuilderProtocol {
    
    func buildListScreen() -> ListScreen {
        let controller = ListScreen(
            itemsService: networkManager,
            parser: parser
        )
        return controller
    }
    
    func buildDetailsScreen(order: OrderInfo) -> DetailsScreen {
        let controller = DetailsScreen(
            order: order,
            imageLoader: networkManager,
            parser: parser
        )
        return controller
    }
    
}
