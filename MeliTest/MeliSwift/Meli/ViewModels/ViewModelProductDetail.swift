//
//  ViewModelProductDetail.swift
//  Meli
//
//  Created by Cristian Tellez on 27/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation

struct ViewModelProductDetail {
 
    let id:String
    private let _title:String
    private let productDetail:ProductDetail
    
    init(product:ProductDetail){
        self.productDetail = product
        self.id = product.id
        self._title = product.title
    }
    
    private func formatPrice(val:NSNumber)->String{
        let formater = NumberFormatter()
        formater.numberStyle = .currency
        formater.currencySymbol =  "$"
        formater.maximumFractionDigits = 2
        formater.minimumFractionDigits = 0
        formater.groupingSeparator = "."
        formater.decimalSeparator = "´"
        return formater.string(from: val) ?? val.description
    }
    
    func price()->String{
        return formatPrice(val: NSNumber(value: self.productDetail.price))
    }
    
    func pictures()->[ProductPicture]{
        return self.productDetail.pictures
    }
    
    var title : String{
        get {
            return self._title
        }
    }
    
    var status : String {
        get {
            return self.productDetail.status
        }
    }
}
