//
//  OrderInfo.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import Foundation

struct OrderInfo: Codable {
    let id: Int
    let startAddress: Address
    let endAddress: Address
    let price: Price
    let orderTime: Date
    let vehicle: Vehicle
}
