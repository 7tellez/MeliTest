//
//  ViewModelProduct.swift
//  Meli
//
//  Created by Cristian Tellez on 26/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation
import UIKit

struct ViewModelProduct {
 
    let id:String
    let title:String
    let thumb:String
    let product:Product
    private let installments : ProductInstallments?
    
    init(product:Product){
        self.product = product
        self.id = product.id
        self.title = product.title
        self.thumb = product.thumbnail
        self.installments = product.installments
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
        return formatPrice(val: NSNumber(value: self.product.price))
    }
    
    func urlImage()->String?{
        return self.thumb
    }
    
    func installment()->String{
        guard let installment = self.installments else {return ""}
        if installment.rate > 0 {
            return installment.quantity.description+"x " + formatPrice(val: NSNumber(value: installment.amount))
        }else{
            return installment.quantity.description+"x " + formatPrice(val: NSNumber(value: self.product.price/Float(installment.quantity)))
        }
    }
    
}
