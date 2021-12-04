//
//  ProductInstallments.swift
//  Meli
//
//  Created by Cristian Tellez on 27/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation

struct ProductInstallments {
    
    var quantity:Int
    var amount:Float
    var rate:Float
 
    
    init(quantity:Int, amount:Float, rate:Float){
        self.quantity = quantity
        self.amount = amount
        self.rate = rate
    }
    
}
    
extension ProductInstallments : Decodable {
    
    enum CodingKeys : String, CodingKey {
        case quantity, amount, rate
    }
    
    init(from decoder:Decoder)throws {
        let instData = try decoder.container(keyedBy: CodingKeys.self)
        
        let quantity = try instData.decode(Int.self, forKey: .quantity)
        let amoutn = try instData.decode(Float.self, forKey: .amount)
        let rate = try instData.decode(Float.self, forKey: .rate)
        
        self.init(quantity: quantity, amount: amoutn, rate: rate)
    }
}
