//
//  OrderParameterView.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import UIKit
import SnapKit

final class OrderParameterView: UIView {
    
    private let titleLabel: UILabel
    private let valueLabel: UILabel
    
    private init(
        title: String,
        value: String
    ) {
        self.titleLabel = ViewsFactory.makeLabel(
            with: title,
            font: .systemFont(ofSize: 20),
            textColor: .black,
            textAlignment: .left,
            numberOfLines: 1
        )
        self.valueLabel = ViewsFactory.makeLabel(
            with: value,
            font: .systemFont(ofSize: 20),
            textColor: .black,
            textAlignment: .right,
            numberOfLines: 1
        )
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 40.0)
    }
    
    class func build(
        title: String,
        value: String
    ) -> OrderParameterView {
        let view = OrderParameterView(title: title, value: value)
        return view
    }
    
}

private extension OrderParameterView {
    
    func setupView() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
        }
        titleLabel.setContentCompressionResistancePriority(
            UILayoutPriority(rawValue: 751),
            for: .horizontal
        )
        addSubview(valueLabel)
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.leading.equalTo(
                titleLabel.snp.trailing
            ).offset(8.0)
        }
    }
    
}
