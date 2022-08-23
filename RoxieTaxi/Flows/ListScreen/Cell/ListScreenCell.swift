//
//  ListScreenCell.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

final class ListScreenCell: UICollectionViewCell {
    
    private let cityNameLabel: UILabel
    private let startAddressLabel: UILabel
    private let endAddressLabel: UILabel
    private let priceLabel: UILabel
    private let dateLabel: UILabel
    private let divider: UIView
    
    override init(frame: CGRect) {
        self.cityNameLabel = ViewsFactory.makeLabel(
            with: "",
            font: .systemFont(ofSize: 18.0),
            textColor: .black,
            textAlignment: .left,
            numberOfLines: 1)
        self.startAddressLabel = ViewsFactory.makeLabel(
            with: "",
            font: .systemFont(ofSize: 18.0),
            textColor: .black,
            textAlignment: .left,
            numberOfLines: 1)
        self.endAddressLabel = ViewsFactory.makeLabel(
            with: "",
            font: .systemFont(ofSize: 18.0),
            textColor: .black,
            textAlignment: .left,
            numberOfLines: 1)
        self.priceLabel = ViewsFactory.makeLabel(
            with: "",
            font: .systemFont(ofSize: 16),
            textColor: .black,
            textAlignment: .left
        )
        self.dateLabel = ViewsFactory.makeLabel(
            with: "",
            font: .systemFont(ofSize: 16),
            textColor: .lightGray,
            textAlignment: .left
        )
        self.divider = ViewsFactory.makeDivider()
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(
        cityName: String,
        startAddress: String,
        endAddress: String,
        price: String,
        date: String
    ) {
        cityNameLabel.text = "City: " + cityName
        startAddressLabel.text = "Start: " + startAddress
        endAddressLabel.text = "End: " + endAddress
        dateLabel.text = date
        priceLabel.text = "Price: " + price
    }
    
    private func setupViews() {
        let padding = 20.0
        let offset = 8.0
        addSubview(cityNameLabel)
        cityNameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(padding)
        }
        addSubview(startAddressLabel)
        startAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(offset)
            make.leading.equalToSuperview().inset(padding)
        }
        addSubview(endAddressLabel)
        endAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(startAddressLabel.snp.bottom).offset(offset)
            make.leading.equalToSuperview().inset(padding)
        }
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(endAddressLabel.snp.bottom).offset(offset)
            make.leading.equalToSuperview().inset(padding)
        }
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(offset)
            make.leading.equalToSuperview().inset(padding)
        }
        addSubview(divider)
        divider.snp.makeConstraints { make in
            make.height.equalTo(1.0)
            make.width.centerX.bottom.equalToSuperview()
        }
    }
    
}
