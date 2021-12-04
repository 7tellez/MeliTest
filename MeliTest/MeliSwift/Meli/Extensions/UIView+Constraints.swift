//
//  UIView+Extension.swift
//  Meli
//
//  Created by Cristian Tellez on 2/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /**
     Margem para lado esquerdo - leftAnchor
     
     - Parameter size: descricao do parameter.
     - Parameter active: descricao do parameter.
     - Parameter viewAnchor: descricao do parameter.
     
     - Returns: NSLayoutConstraint
     */
    @discardableResult
    func left(leftAnchor:NSLayoutXAxisAnchor, size: CGFloat, active:Bool = true)->NSLayoutConstraint{
        let leftMargin = self.leftAnchor.constraint(equalTo: leftAnchor, constant: size)
        leftMargin.isActive = active
        return leftMargin
    }
    /**
     Margem para lado direito - rightAnchor
     
     - Parameter size: descricao do parameter.
     - Parameter active: descricao do parameter.
     - Parameter viewAnchor: descricao do parameter.
     
     - Returns: NSLayoutConstraint
     */
    @discardableResult
    func right(rightAnchor:NSLayoutXAxisAnchor, size: CGFloat, active:Bool = true)->NSLayoutConstraint{
        let rightMargin = self.rightAnchor.constraint(equalTo: rightAnchor, constant: -size)
        rightMargin.isActive = active
        return rightMargin
    }
    /**
     Margem para Top
     
     - Parameter size: descricao do parameter.
     - Parameter active: descricao do parameter.
     - Parameter viewAnchor: descricao do parameter.
     
     - Returns: NSLayoutConstraint
     */
    @discardableResult
    func top(topAnchor:NSLayoutYAxisAnchor, size: CGFloat, active:Bool = true)->NSLayoutConstraint{
        let topMargin = self.topAnchor.constraint(equalTo: topAnchor, constant: size)
        topMargin.isActive = active
        return topMargin
    }
    /**
     Margem para rodapé - Bottom
     
     - Parameter size: descricao do parameter.
     - Parameter active: descricao do parameter.
     - Parameter viewAnchor: descricao do parameter.
     
     - Returns: NSLayoutConstraint
     */
    @discardableResult
    func bottom(bottomAnchor:NSLayoutYAxisAnchor, size: CGFloat, active:Bool = true)->NSLayoutConstraint{
        let bottomMargin = self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -size)
        bottomMargin.isActive = active
        return bottomMargin
    }
    /**
     Largura da View - Width
     
     - Parameter size: descricao do parameter.
     - Parameter active: descricao do parameter.
     - Parameter viewAnchor: descricao do parameter.
     
     - Returns: NSLayoutConstraint
     */
    @discardableResult
    func width(size:CGFloat, active:Bool = true, multiplier:CGFloat = 1.0, widthToView:NSLayoutDimension? = nil)->NSLayoutConstraint{
        if (widthToView != nil){
            let width = self.widthAnchor.constraint(equalTo: widthToView!, multiplier: multiplier, constant: size)
            width.isActive = active
            return width
        }else{
            let width = self.widthAnchor.constraint(equalToConstant: size)
            width.isActive = active
            return width
        }
    }
    /**
     Altura da View, height
     
     - Parameter size: descricao do parameter.
     - Parameter active: descricao do parameter.
     - Parameter viewAnchor: descricao do parameter.
     
     - Returns: NSLayoutConstraint
     */
    @discardableResult
    func height(size:CGFloat, active:Bool = true, multiplier:CGFloat = 1.0, heightToView:NSLayoutDimension? = nil)->NSLayoutConstraint{
        if (heightToView != nil){
            let height = self.heightAnchor.constraint(equalTo: heightToView!, multiplier: multiplier, constant: size)
            height.isActive = active
            return height
        }else{
            let height = self.heightAnchor.constraint(equalToConstant: size)
            height.isActive = active
            return height
        }
    }
    /**
     Margem para centralizar na horizontal = CenterXAnchor
     
     - Parameter size: descricao do parameter.
     - Parameter active: descricao do parameter.
     - Parameter viewAnchor: descricao do parameter.
     
     - Returns: NSLayoutConstraint
     */
    @discardableResult
    func centerX(horizontal centerX:NSLayoutXAxisAnchor, size:CGFloat = 0.0, active:Bool = true)->NSLayoutConstraint{
        let center = self.centerXAnchor.constraint(equalTo: centerX, constant: size)
        center.isActive = active
        return center
    }
    /**
     Margem para centralizar na vertical - CenterYAnchor
     
     - Parameter size: descricao do parameter.
     - Parameter active: descricao do parameter.
     - Parameter viewAnchor: descricao do parameter.
     
     - Returns: NSLayoutConstraint
     */
    @discardableResult
    func centerY(vertical centerY:NSLayoutYAxisAnchor, size:CGFloat = 0.0, active:Bool = true)->NSLayoutConstraint{
        let center = self.centerYAnchor.constraint(equalTo: centerY, constant: size)
        center.isActive = active
        return center
    }
    
    /**
     Margem automática para uma subview em relação a viewParent
     
     - Parameter subView: view a ser adicionada sobre a parentView.
     
     */
    func autoMarginView(subView:UIView){
        self.addSubview(subView)
        _ = subView.top(topAnchor: self.topAnchor, size: 0)
        _ = subView.left(leftAnchor: self.leftAnchor, size: 0)
        _ = subView.right(rightAnchor: self.rightAnchor, size: 0)
        _ = subView.bottom(bottomAnchor: self.bottomAnchor, size: 0)
    }
}
