//
//  ListScreen.swift
//  RoxieTest
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import UIKit
import SnapKit

final class ListScreen: UIViewController {
    
    var close: CompletionBlock?
    var onDetailScreen: ((OrderInfo) -> Void)?
    
    private lazy var collectionView = makeCollectionView()
    private let itemsService: ItemsService
    private let padding: CGFloat = 20.0
    private let parser: OrderInfoParser
    
    init(
        itemsService: ItemsService,
        parser: OrderInfoParser
    ) {
        self.itemsService = itemsService
        self.parser = parser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

extension ListScreen: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        itemsService.count()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListScreenCell.reuseIdentifier,
            for: indexPath
        ) as? ListScreenCell else { fatalError("Collection cell error.") }
        if let item = itemsService.getItem(with: indexPath.item) {
            DispatchQueue.main.async {
                cell.set(
                    cityName: item.startAddress.city,
                    startAddress: item.startAddress.address,
                    endAddress: item.endAddress.address,
                    price: self.parser.priceString(item.price),
                    date: self.parser.dateString(item.orderTime)
                )
            }
        }
        return cell
    }
    
}

extension ListScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.frame.width - (padding * 2), height: 160.0)
    }

}

extension ListScreen: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let item = itemsService.getItem(with: indexPath.item) else { return }
        onDetailScreen?(item)
    }
}

private extension ListScreen {
    
    func makeCollectionView() -> UICollectionView {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        view.dataSource = self
        view.delegate = self
        view.register(
            ListScreenCell.self,
            forCellWithReuseIdentifier: ListScreenCell.reuseIdentifier
        )
        return view
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(padding)
        }
    }
    
    func setupViews() {
        self.title = "Orders"
        navigationController?.isNavigationBarHidden = false
        setupCollectionView()
    }
    
}
