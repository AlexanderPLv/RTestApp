//
//  ViewsFactory.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import UIKit

enum ViewsFactory {
    static func makeLabel(
        with text: String,
        font: UIFont,
        textColor: UIColor,
        textAlignment: NSTextAlignment,
        numberOfLines: Int = 0
    ) -> UILabel {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.text = text
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func makeScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }
    
    static func makeDivider() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.1)
        return view
    }
    
}
