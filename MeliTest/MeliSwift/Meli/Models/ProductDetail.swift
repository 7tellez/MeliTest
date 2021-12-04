//
//  ProductDetail.swift
//  Meli
//
//  Created by Cristian Tellez on 1/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation



struct ProductDetail  {
    
    var id:String
    var site_id:String
    var title:String
    var subtitle:String?
    var price:Float
    var base_price:Float
    var currency_id:String
    var available_quantity:Int
    var permalink:String
    var secure_thumbnail:String
    var attributes : [ProductAttribute]
    var warranty:String
    var status : String
    var pictures:[ProductPicture]
    
    init(id:String, site_id:String, title:String, price:Float, currency_id:String, qtd_available:Int, permalink:String, sec_thumbnail:String, base_price:Float, attributes:[ProductAttribute], warranty:String, status:String, pictures:[ProductPicture], subtitle:String?){
        self.id = id
        self.site_id = site_id
        self.title = title
        self.price = price
        self.currency_id = currency_id
        self.available_quantity = qtd_available
        self.permalink = permalink
        self.secure_thumbnail = sec_thumbnail
        self.status = status
        self.warranty = warranty
        self.pictures = pictures
        self.attributes = attributes
        self.base_price = base_price
        self.subtitle = subtitle
    }
}



extension ProductDetail : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case site_id
        case title
        case price
        case currency_id
        case available_quantity
        case permalink
        case secure_thumbnail
        case attributes
        case pictures
        case base_price
        case warranty
        case subtitle
        case status
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
        let thumb = try productData.decode(String.self, forKey: .secure_thumbnail)
        //let attributes = try productData.decode([ProductAttribute].self, forKey: .attributes)
        let attributes : [ProductAttribute] = []
        let pictures = try productData.decode([ProductPicture].self, forKey: .pictures)
        let base_price = try productData.decode(Float.self, forKey: .base_price)
        let warranty = try productData.decode(String.self, forKey: .warranty)
        let subtitle = try productData.decodeIfPresent(String.self, forKey: .subtitle)
        let status = try productData.decode(String.self, forKey: .status)
        
        self.init(id:id, site_id:site_id, title: title, price: price, currency_id: currency_id, qtd_available:available_quantity, permalink:permalink, sec_thumbnail: thumb, base_price:base_price,attributes:attributes, warranty:warranty, status:status, pictures:pictures, subtitle:subtitle)
    }
}




