//
//  NetworkManager.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import UIKit

protocol ListDataProvider {
    func loadOrders(
        completion: @escaping (Error?) -> Void
    )
}

protocol ItemsService {
    func loadOrders(
        completion: @escaping (Error?) -> Void
    )
    func count() -> Int
    func getItem(with index: Int) -> OrderInfo?
}

protocol ImageLoader {
    func loadImage(
        with name: String,
        completion: @escaping (Result<Data, Error>) -> Void
    )
}

final class NetworkManager {
    
    private let cache = Cache<String, Data>()
    private let requestFactory: RequestFactory
    private var orders: [OrderInfo]?
    private let ordersAccessQueue = DispatchQueue(
        label: "OrdersAccessQueue",
        attributes: .concurrent
    )
    
    private init(
        requestFactory: RequestFactory
    ) {
        self.requestFactory = requestFactory
    }
    
    class func build(with factory: RequestFactory) -> NetworkManager {
        let manager = NetworkManager(requestFactory: factory)
        return manager
    }
    
}

extension NetworkManager: ImageLoader {
    func loadImage(
        with name: String,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        if let data = cache[name] {
            completion(.success(data))
        } else {
            let request = requestFactory.makeGetImageRequest()
            request.get(with: name) { [weak self] result in
                switch result {
                case .success(let result):
                    if let data = result.first?.data {
                        self?.cache[name] = data
                        completion(.success(data))
                    } else {
                        completion(.failure(NetworkError.badData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

extension NetworkManager: ItemsService {
    
    private func set(_ orders: [OrderInfo]) {
        ordersAccessQueue.sync(flags: .barrier) {
            self.orders = orders
                .sorted(by: {$0.orderTime > $1.orderTime})
        }
    }
    
    func getItem(with index: Int) -> OrderInfo? {
        ordersAccessQueue.sync {
            guard let items = self.orders,
                  index < items.count else { return nil }
            return items[index]
        }
    }
    
    func count() -> Int {
        ordersAccessQueue.sync {
            guard let items = self.orders else { return 0 }
            return items.count
        }
    }
    
}

extension NetworkManager: ListDataProvider {
    func loadOrders(
        completion: @escaping (Error?) -> Void
    ) {
        let request = requestFactory.makeGetOrdersRequest()
        request.get { [weak self] result in
            switch result {
            case .success(let orders):
                self?.set(orders)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
