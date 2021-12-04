//
//  ProductService.swift
//  Meli
//
//  Created by Cristian Tellez on 1/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation


struct ProductService {

    typealias ResultProductsSearch = (_ success:Bool, _ products:[Product], _ msg:String?, _ paginaAtual:Int)->()
    
    /**
            Searchs products
            params:
            - id: identifier of product for detail
            - pagina: paginacao (20 per page)
            return:
            - ProductDetail
     */
    public static func searchProducts(by text:String, page:Int=1, completion: @escaping ResultProductsSearch){
        APIRequest.request(url: Endpoints.searchProducts(by: text, page: 1), returning: .json) { (response) in
            switch (response) {
            case .sucess(let json, let msg):
                
                do {
                    guard let _json = json as? Dictionary<String,Any> else { completion(false, [], msg, page); return; }
                    guard let productsJson = _json["results"] as? Array<Dictionary<String,Any>> else { completion(false, [], "Nothing Found", page); return; }
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: productsJson, options: [])
                    let products = try JSONDecoder().decode([Product].self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(true, products, msg, page)
                    }
                    
                }catch(let e){
                    DispatchQueue.main.async {
                        completion(false, [], e.localizedDescription, page)
                    }
                }
                
            case .error(_, let msg):
                DispatchQueue.main.async {
                    completion(false, [], msg, page)
                }
            }
        }
    }
    
}

