//
//  OnboardingScreen.swift
//  RoxieTest
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import UIKit
import SnapKit

final class OnboardingScreen: UIViewController {
    
    var close: CompletionBlock?
    var finishFlow: (([OrderInfo]) -> Void)?
    
    private let label: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 55)
        view.textColor = .black
        view.text = "RoxieTaxi"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dataProvider: ListDataProvider
    
    init(dataProvider: ListDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        prefetchOrders()
    }
    
    private func prefetchOrders() {
        dataProvider.loadOrders { [weak self] error in
            if let error = error {
                // check connection alert
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self?.close?()
                }
            }
        }
    }
    
}

private extension OnboardingScreen {
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
