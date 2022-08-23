//
//  MainCoordinator.swift
//  RoxieTest
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import Foundation

protocol MainCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
 
final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let factory: MainBuilderProtocol
    fileprivate let router: Routable
    
    init(router: Routable, factory: MainBuilderProtocol) {
        self.router = router
        self.factory = factory
    }
}
 
extension MainCoordinator: Coordinator {
    func start() {
        performFlow()
    }
}

private extension MainCoordinator {
    func performFlow() {
        let view = factory.buildListScreen()
        view.onDetailScreen = { [weak self] order in
            self?.runDetailScreen(order: order)
        }
        view.close = finishFlow
        router.setRootModule(view, hideBar: true)
    }
    
    func runDetailScreen(order: OrderInfo) {
        let view = factory.buildDetailsScreen(order: order)
        view.close = pop
        router.push(view, animated: true)
    }
    
    func pop() {
        router.popModule()
    }
    
}
