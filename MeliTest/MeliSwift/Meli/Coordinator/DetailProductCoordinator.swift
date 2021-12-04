//
//  DetailProductCoordinator.swift
//  Meli
//
//  Created by Cristian Tellez on 27/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation
import UIKit

protocol BackToHomeViewControllerDelegate : class {
    func backToHome(newOrder:DetailProductCoordinator)
}

class DetailProductCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    unowned let presenter : UINavigationController
    private let idProduct:String
    
    weak var delegate: BackToHomeViewControllerDelegate?
    
    init(presenter: UINavigationController, idProduct:String) {
        self.presenter = presenter
        self.idProduct = idProduct
    }
    
    func start() {
        let detView = DetailProductViewController(product: self.idProduct)
        detView.delegate = self
        self.presenter.pushViewController(detView, animated: true)
    }
    
}


extension DetailProductCoordinator : DetailProductViewControllerDelegate {
    func backToHome() {
        self.delegate?.backToHome(newOrder: self)
    }
}


