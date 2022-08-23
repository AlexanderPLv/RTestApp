//
//  DetailsScreen.swift
//  RoxieTest
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import UIKit

final class DetailsScreen: UIViewController {
    
    var close: CompletionBlock?
    
    private let order: OrderInfo
    private let parser: OrderInfoParser
    private let imageLoader: ImageLoader
    private let imageView: UIImageView
    private let scrollView: UIScrollView
    private let padding: CGFloat = 20.0
    
    private let cityNameView: UIView
    private let startLocationView: UIView
    private let endLocationView: UIView
    private let driverNameView: UIView
    private let modelView: UIView
    private let regNumberView: UIView
    private let orderTimeView: UIView
    private let priceView: UIView
    
    init(
        order: OrderInfo,
        imageLoader: ImageLoader,
        parser: OrderInfoParser
    ) {
        self.order = order
        self.imageLoader = imageLoader
        self.parser = parser
        self.imageView = UIImageView()
        self.scrollView = ViewsFactory.makeScrollView()
        self.cityNameView = OrderParameterView.build(
            title: "City:",
            value: order.startAddress.city
        )
        self.startLocationView = OrderParameterView.build(
            title: "Start:",
            value: order.startAddress.address
        )
        self.endLocationView = OrderParameterView.build(
            title: "End:",
            value: order.endAddress.address
        )
        self.driverNameView = OrderParameterView.build(
            title: "Driver name:",
            value: order.vehicle.driverName
        )
        self.modelView = OrderParameterView.build(
            title: "Model:",
            value: order.vehicle.modelName
        )
        self.regNumberView = OrderParameterView.build(
            title: "Reg. number:",
            value: order.vehicle.regNumber
        )
        self.orderTimeView = OrderParameterView.build(
            title: "Order time:",
            value: parser.dateString(order.orderTime)
        )
        self.priceView = OrderParameterView.build(
            title: "Price:",
            value: parser.priceString(order.price)
        )
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        DispatchQueue.main.async {
            self.tryToGetImage()
        }
    }
    
}

private extension DetailsScreen {
    
    func tryToGetImage() {
        imageLoader.loadImage(
            with: order.vehicle.photo) { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let data):
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imageView.image = image
                        }
                    }
                }
            }
    }
    
    func setupNavigationButtons() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "<Back",
            style: .plain,
            target: self,
            action: #selector(handleCancel)
        )
    }
    
    @objc func handleCancel() {
        close?()
    }
    
    func makeStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [
        cityNameView,
        startLocationView,
        endLocationView,
        driverNameView,
        modelView,
        regNumberView,
        orderTimeView,
        priceView
        ])
        stack.axis = .vertical
        stack.spacing = 8.0
        stack.distribution = .fillEqually
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: padding,
            leading: padding,
            bottom: 0,
            trailing: padding)
        return stack
    }
    
    func setupViews() {
        setupNavigationButtons()
        view.backgroundColor = .white
        self.title = "Order details"
        view.addSubview(imageView)
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleToFill
        imageView.snp.makeConstraints { make in
            make.height.equalTo(view.bounds.height / 3)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        let stackView = makeStackView()
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            cityNameView.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor,
                constant: -(padding * 2)
            )
        ])
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(
                imageView.snp.bottom
            )
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(
                view.safeAreaLayoutGuide.snp.bottom
            )
        }
    }
    
}
