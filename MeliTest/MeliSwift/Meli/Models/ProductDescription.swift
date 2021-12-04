//
//  ProductDescription.swift
//  Meli
//
//  Created by Cristian Tellez on 27/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation
struct ProductDescription {
    
    var plain_text:String
    
    init(plain_text:String){
        self.plain_text = plain_text
    }
    
}
    
extension ProductDescription : Decodable {
    
    enum CodingKeys : String, CodingKey {
        case plain_text
    }
    
    init(from decoder:Decoder)throws {
        let instData = try decoder.container(keyedBy: CodingKeys.self)
        
        let plain_text = try instData.decode(String.self, forKey: .plain_text)
        
        self.init(plain_text: plain_text)
    }
}
