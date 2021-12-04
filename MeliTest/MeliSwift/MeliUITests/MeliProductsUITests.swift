//
//  MeliUITests.swift
//  MeliUITests
//
//  Created by Cristian Tellez on 2/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import XCTest
@testable import Meli

class MeliUITests: XCTestCase {

    var totalRegister : Int!
    var serviceProduct : ProductService!
    
    override func setUp() {
        super.setUp()
        
        
        continueAfterFailure = false
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_fetch_produtcts(){
        
        let expect = XCTestExpectation(description: "fetchProducts macbook site MLB")
        
        ProductService.searchProducts(by: "macbook") { (succ, products, msg, pagina) in
            XCTAssertEqual(products.count, Endpoints.TOTAL_PER_PAGE)
            
            for product in products {
                XCTAssertNotNil(product.id)
                XCTAssertNotNil(product.title)
                XCTAssertNotNil(product.price)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 10)
    }
    
    func teste_fetch_product_detail() {
        
        let productID = "MLB1195418122"
        let expectDetail = XCTestExpectation(description: "Fetch product detail")
        
        ProductDetailService.getDetailProduct(product: productID) { (scc, prod, msg) in
            XCTAssert(scc)
            XCTAssertNotNil(prod)
            XCTAssert(prod!.price > 0)
            expectDetail.fulfill()
        }
        
        wait(for: [expectDetail], timeout: 2)
    }
    
    func test_fetch_product_detail_not_exist(){
        let productID = "MLB"
        let expectDetail = XCTestExpectation(description: "Fetch product detail not exist")
        
        ProductDetailService.getDetailProduct(product: productID) { (scc, prod, msg) in
            XCTAssertFalse(scc)
            XCTAssertNil(prod)
            XCTAssert(msg!.contains("not found"))
            expectDetail.fulfill()
        }
        
        wait(for: [expectDetail], timeout: 5)
    }
    
    func test_product_viewmodel() {
        let expect = XCTestExpectation(description: "check viewmodel is ready")
        
        ProductService.searchProducts(by: "macbook") { (succ, products, msg, pagina) in
            XCTAssertEqual(products.count, Endpoints.TOTAL_PER_PAGE)
            
            for product in products {
                XCTAssertNotNil(product.id)
                XCTAssertNotNil(product.title)
                XCTAssertNotNil(product.price)
                
                let viewModel = ViewModelProduct(product: product)
                
                XCTAssertEqual(viewModel.title, product.title)
                XCTAssertEqual(viewModel.id, product.id)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 10)
    }
    
    func test_product_description() {
        let productID = "MLB1195418122"
        let expectDetail = XCTestExpectation(description: "Fetch product description")
       
        ProductDetailService.getDescriptionProduct(product: productID) { (scc, prod, msg) in
            XCTAssert(scc)
            XCTAssertNotNil(prod)
            XCTAssert(prod!.plain_text.count > 0)
           expectDetail.fulfill()
        }
       
        wait(for: [expectDetail], timeout: 5)
    }
}
