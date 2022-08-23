//
//  OrderInfoParser.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import Foundation

protocol OrderInfoParser {
    func priceString(_ price: Price) -> String
    func dateString(_ date: Date) -> String
}

final class Parser: OrderInfoParser {
    
    static let shared = Parser()
    
    private init() {
        
    }
    
    func priceString(_ price: Price) -> String {
        let myformatter = NumberFormatter()
        myformatter.numberStyle = .currencyISOCode
        let newLocale = "\(Locale.current.identifier)@currency=\(price.currency)"
        myformatter.locale = Locale(identifier: newLocale)
        guard let string = myformatter.string(from: (price.amount / 100) as NSNumber) else {
            return "--"
        }
        return string
    }
    
    func dateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}
