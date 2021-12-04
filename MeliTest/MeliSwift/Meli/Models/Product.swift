//
//  Products.swift
//  Meli
//
//  Created by Cristian Tellez on 1/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation

struct Product {
    
    var id:String
    var site_id:String
    var title:String
    var price:Float
    var currency_id:String
    var available_quantity:Int
    var permalink:String
    var thumbnail:String
    var installments : ProductInstallments?
    
    init(id:String, site_id:String, title:String, price:Float, currency_id:String, qtd_available:Int, permalink:String, thumbnail:String, installments: ProductInstallments){
        self.id = id
        self.site_id = site_id
        self.title = title
        self.price = price
        self.currency_id = currency_id
        self.available_quantity = qtd_available
        self.permalink = permalink
        self.thumbnail = thumbnail
        self.installments = installments
    }
}



extension Product : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case site_id
        case title
        case price
        case currency_id
        case available_quantity
        case permalink
        case thumbnail
        case installments
    }
    
    
    init(from decoder: Decoder) throws {
        let productData = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try productData.decode(String.self, forKey: .id)
        let site_id = try productData.decode(String.self, forKey: .site_id)
        let title = try productData.decode(String.self, forKey: .title)
        let price = try productData.decode(Float.self, forKey: .price)
        let currency_id = try productData.decode(String.self, forKey: .currency_id)
        let available_quantity = try productData.decode(Int.self, forKey: .available_quantity)
        let permalink = try productData.decode(String.self, forKey: .permalink)
        let thumb = try productData.decode(String.self, forKey: .thumbnail)
        let installments = try productData.decode(ProductInstallments.self, forKey: .installments)
        
        self.init(id:id, site_id:site_id, title: title, price: price, currency_id: currency_id, qtd_available:available_quantity, permalink:permalink, thumbnail: thumb, installments: installments)
    }
}

