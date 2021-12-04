//
//  PictureCollectionViewCell.swift
//  Meli
//
//  Created by Cristian Tellez on 27/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {

    static func loadNib()->UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    static func identifier()->String{
        return String(describing: self)
    }
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setImageProduct(url:String){
        loader.startAnimating()
        APIRequest.downloadImagem(url: url) { (scc, img) in
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.imgProduct.image = img
            }
        }
    }
}
