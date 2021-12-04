//
//  HomeCoordinator.swift
//  Meli
//
//  Created by Cristian Tellez on 2/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    unowned let presenter : UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let homeView = HomeViewController()
        homeView.delegate = self
        presenter.pushViewController(homeView, animated: false)
    }
}

extension HomeCoordinator : HomeViewControllerDelegate {
    func navigateToDetailProduct(id: String) {
        let productdetail = DetailProductCoordinator(presenter: self.presenter, idProduct: id)
        productdetail.delegate = self
        childCoordinators.append(productdetail)
        productdetail.start()
    }
}


extension HomeCoordinator : BackToHomeViewControllerDelegate {
    func backToHome(newOrder: DetailProductCoordinator) {
        self.presenter.popViewController(animated: true)
        
        childCoordinators.removeAll()
    }
}
