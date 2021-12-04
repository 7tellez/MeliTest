//
//  ProductCollectionViewCell.swift
//  Meli
//
//  Created by Cristian Tellez on 26/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    
    private var productViewModel : ViewModelProduct!
    
    var isLoading : Bool = false {
        didSet {
            if (self.isLoading){
                self.startLoading()
            }else{
                self.stopLoading()
            }
        }
    }
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbInstallments: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet var activityViewLoading: UIActivityIndicatorView!
    
    static func loadNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func identifier()->String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .clear
        self.card.layer.cornerRadius = 10

    }

    func setViewModel(vm: ViewModelProduct){
        self.productViewModel = vm
        self.configureCellProduct()
    }
    
    private func configureCellProduct(){
        
        self.lbPrice.text = self.productViewModel.price()
        self.lbTitle.text = self.productViewModel.title
        self.lbInstallments.text = self.productViewModel.installment()
        guard let urlImg = self.productViewModel.urlImage() else {return}
       
        self.loader.startAnimating()
        APIRequest.downloadImagem(url: urlImg) {[weak self] (succ, img) in
            DispatchQueue.main.async {
                self?.imgProduct.image = img
                self?.loader.stopAnimating()
            }
        }
        
        
    }
    
    private func startLoading(){
        self.activityViewLoading.startAnimating()
        self.viewLoading.isHidden = false
    }
    
    private func stopLoading(){
        UIView.animate(withDuration: 0.2, animations: {
            self.activityViewLoading.alpha = 0
        }) { (fim) in
            self.activityViewLoading.stopAnimating()
            self.viewLoading.isHidden = true
            self.activityViewLoading.alpha = 1.0
        }
    }
}
