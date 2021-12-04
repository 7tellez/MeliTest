//
//  ProductDetailService.swift
//  Meli
//
//  Created by Cristian Tellez on 1/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation


struct ProductDetailService {

    typealias ResultProductDetail = (_ success:Bool, _ product:ProductDetail?, _ msg:String?)->()
    typealias ResultProductDescription = (_ success:Bool, _ product:ProductDescription?, _ msg:String?)->()
    
    /**
            Get info detail of product
            params:
            - id: identifier of product for detail
            return:
            - ProductDetail
     */
    public static func getDetailProduct(product id:String, completion: @escaping ResultProductDetail){
        APIRequest.request(url: Endpoints.productDetail(detail: id), returning: .data) { (response) in
            switch (response) {
            case .sucess(let data, let msg):
              
                do {
                    guard let _data = data as? Data else { completion(false, nil, msg); return; }
                    let products = try JSONDecoder().decode(ProductDetail.self, from: _data)
                    completion(true, products, msg)
                }catch(let e){
                    completion(false, nil, e.localizedDescription)
                }
                
            case .error(_, let msg):
                
                completion(false, nil, msg)
            }
        }
    }
    
    /**
           Get info description of product
           params:
           - id: identifier of product for detail
           return:
           - ProductDetail
    */
    public static func getDescriptionProduct(product id:String, completion: @escaping ResultProductDescription){
        APIRequest.request(url: Endpoints.productDescription(detail: id), returning: .data) { (response) in
            switch (response) {
            case .sucess(let data, let msg):
              
                do {
                    guard let _data = data as? Data else { completion(false, nil, msg); return; }
                    let prod = try JSONDecoder().decode(ProductDescription.self, from: _data)
                    completion(true, prod, msg)
                }catch(let e){
                    completion(false, nil, e.localizedDescription)
                }
                
            case .error(_, let msg):
                
                completion(false, nil, msg)
            }
        }
    }
}
