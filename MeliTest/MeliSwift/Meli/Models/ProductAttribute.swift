//
//  ProductAttribute.swift
//  Meli
//
//  Created by Cristian Tellez R Silva on 26/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation


struct ProductAttribute {
    
    var id:String
    var name:String
    var value_id:String
    var value_name:String
    var attribute_group_id:String
    var attribute_group_name:String
 
    
    init(id:String, name:String, value_id:String, value_name:String, att_group_id:String, attr_group_name:String){
        self.id = id
        self.name = name
        self.value_id = value_id
        self.value_name = value_name
        self.attribute_group_id = att_group_id
        self.attribute_group_name = attr_group_name
    }
    
}
    
extension ProductAttribute : Decodable {
    
    enum CodingKeys : String, CodingKey {
        case id, name, value_id, value_name, attribute_group_id, attribute_group_name
    }
    
    init(from decoder:Decoder)throws {
        let attrData = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try attrData.decode(String.self, forKey: .id)
        let name = try attrData.decode(String.self, forKey: .name)
        let value_id = try attrData.decode(String.self, forKey: .value_id)
        let value_name = try attrData.decode(String.self, forKey: .value_name)
        let attribute_group_id = try attrData.decode(String.self, forKey: .attribute_group_id)
        let attribute_group_name = try attrData.decode(String.self, forKey: .attribute_group_name)
        
        self.init(id:id, name:name, value_id:value_id, value_name:value_name, att_group_id:attribute_group_id, attr_group_name:attribute_group_name)
    }
}
