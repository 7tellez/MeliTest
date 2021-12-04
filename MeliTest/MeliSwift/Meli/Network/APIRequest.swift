//
//  APIRequest.swift
//  Meli
//
//  Created by Cristian Tellez on 1/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation
import UIKit

typealias Result = (_ result:EnumResultRequest)->()


/*
 Api Request Class
 */
struct APIRequest {
    
    private init(){}
    
    private static let shareSession : URLSession = URLSession.shared;
    
    static func request(url endpoint:String, method:EnumHttpMethod = .get, params:Dictionary<String,Any>?=nil, encoding:EnumEncoding = .json, returning: EnumReturningType = .data, completion: @escaping Result){
        
        let escaped = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? endpoint
        guard let url = URL(string: escaped) else {
            completion(.error(error: nil, msg: "Please, check your url format"))
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(encoding.rawValue, forHTTPHeaderField: "Content-Type")
        if (method == .post && params != nil) {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params!, options: [])
            }catch (let ex){
                NSLog("Error in encoded data post %@", ex.localizedDescription)
            }
        }
        
        // start session datatask
        let dataTask = shareSession.dataTask(with: urlRequest) { (data, response, error) in
            
            // check statuscode return
            if let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode > 301 {
                let json = String(data: data ?? Data(), encoding: .utf8)
                DispatchQueue.main.async {
                    completion(.error(error: nil, msg: json))
                }
                return
            }
            
            
            if (error != nil) {
                completion(.error(error: error, msg: error?.localizedDescription))
                return
            }
            
            guard let _data = data else {
                DispatchQueue.main.async {
                    completion(.error(error: nil, msg: "No data"))
                }
                return
            }
            
            if (returning == .json) {
                do{
                    let json = try JSONSerialization.jsonObject(with: _data, options: .allowFragments)
                    DispatchQueue.main.async {
                        completion(.sucess(data: json, msg: "Json is OK"))
                    }
                }catch(let er){
                    OperationQueue.main.addOperation({
                        completion(.error(error: er, msg: endpoint+": "+er.localizedDescription))
                    })
                }
            }
            else {
                completion(.sucess(data: _data, msg: "Data is OK"))
            }
            
        }
        
        // start request
        dataTask.resume()
    }
    
    static func downloadImagem(url:String, handler: @escaping (_ status:Bool, _ imagem:UIImage)->()){
           if let urlRequest = URL(string: url) {
               DispatchQueue.global().async {
                   URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                       if let d = data {
                           if let img = UIImage(data: d) {
                               handler(true, img)
                               return
                           }
                       }
                       handler(false, UIImage())
                   }.resume()
               }
           }
       }

}

