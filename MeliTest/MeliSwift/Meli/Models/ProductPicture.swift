//
//  ProductPicture.swift
//  Meli
//
//  Created by Cristian Tellez R Silva on 26/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation

struct ProductPicture {
    var id : String
    var url: String
    
    init(id:String, url:String){
        self.id = id
        self.url = url
    }
    
}

extension ProductPicture : Decodable {
    enum CodingKeys : String, CodingKey {
        case id
        case url = "secure_url"
    }
    
    init(from decoder: Decoder) throws {
        let picData = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try picData.decode(String.self, forKey: .id)
        let url = try picData.decode(String.self, forKey: .url)
        
        self.init(id:id, url:url)
    }
}
