//
//  Endpoints.swift
//  Meli
//
//  Created by Cristian Tellez on 1/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation


struct Endpoints {
    
    static let API_BASE = "https://api.mercadolibre.com/"
    static let SITE = "MCO"
    static let TOTAL_PER_PAGE : Int = 30
    
    static func searchProducts(by text:String, page:Int=1)->String{
        return String(format: "%@sites/%@/search?q=%@&offset=%@&limit=%@", API_BASE, SITE, text, (page-1).description, TOTAL_PER_PAGE.description)
    }
    
    static func productDetail(detail itemID:String)->String {
        return String(format: "%@items/%@", API_BASE, itemID)
    }
    
    static func productDescription(detail itemID:String)->String {
           return String(format: "%@items/%@/description", API_BASE, itemID)
       }
    
}
