//
//  ViewModelProductDescription.swift
//  Meli
//
//  Created by Cristian Tellez on 27/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation

struct ViewModelProductDescription {
 
    private let productDescription:ProductDescription
    
    init(product:ProductDescription){
        self.productDescription = product
    }
    
 
    var text : String{
        get {
            return self.productDescription.plain_text.isEmpty ? "No Description for Product" : self.productDescription.plain_text
        }
    }
}
