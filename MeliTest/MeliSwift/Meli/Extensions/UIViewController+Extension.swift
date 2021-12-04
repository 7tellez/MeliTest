//
//  UIViewController+Extension.swift
//  Meli
//
//  Created by Cristian Tellez on 2/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /**
    Adicionar viewViewController como childview a um container

    - Parameter viewForAdd: view para ser adicionada.
    - Parameter containerView: uma view onde será adicionada as constraints.

    - Returns: child view Adicionada
    */
    func adicionaViewChild(childView viewController: UIViewController, containerView:UIView? = nil){
       
       addChild(viewController)
       
       viewController.view.translatesAutoresizingMaskIntoConstraints = false
       if containerView != nil {
           containerView!.addSubview(viewController.view)
           _ = viewController.view.top(topAnchor: containerView!.topAnchor, size: 0)
           _ = viewController.view.left(leftAnchor: containerView!.leftAnchor, size: 0)
           _ = viewController.view.right(rightAnchor: containerView!.rightAnchor, size: 0)
           _ = viewController.view.bottom(bottomAnchor: containerView!.bottomAnchor, size: 0)
       }else{
           view.addSubview(viewController.view)
           _ = viewController.view.top(topAnchor: view.topAnchor, size: 0)
           _ = viewController.view.left(leftAnchor: view.leftAnchor, size: 0)
           _ = viewController.view.right(rightAnchor: view.rightAnchor, size: 0)
           _ = viewController.view.bottom(bottomAnchor: view.bottomAnchor, size: 0)
       }
       viewController.didMove(toParent: self)
    }

    /**
    Remove childViewController

    - Parameter viewsControllers: Array de views a serem removidas.

    - Returns: ViewsRemovidas
    */
    func removeViewChild(viewsForRemove childsViews:UIViewController...){
       for viewChild in childsViews {
           viewChild.willMove(toParent: nil)
           viewChild.view.removeFromSuperview()
           viewChild.removeFromParent()
       }
    }
       
    
    func showAlert(msg:String, title:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
