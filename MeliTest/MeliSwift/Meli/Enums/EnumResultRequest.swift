//
//  EnumResultRequest.swift
//  Meli
//
//  Created by Cristian Tellez on 1/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation


enum EnumResultRequest {
    case error(error:Error?, msg:String?)
    case sucess(data:Any?,msg:String?)
}
