//
//  DetailProductPicturesCell.swift
//  Meli
//
//  Created by Cristian Tellez on 27/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import UIKit

class DetailProductPicturesCell: UITableViewCell {
    
    static func loadNib()->UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    static func identifier()->String{
        return String(describing: self)
    }

    var viewModel : ViewModelProductDetail!
    var currentPageImg:Int = 1 {
        didSet {
            lbPageCurrent.text = (self.currentPageImg+1).description+"/"+viewModel.pictures().count.description
        }
    }
    
    @IBOutlet weak var collectionViewPictures: UICollectionView!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbPageCurrent: UILabel!
    @IBOutlet weak var lbTitleProduct: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initCollectionViewPictures()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initCollectionViewPictures(){
        collectionViewPictures.register(PictureCollectionViewCell.loadNib(), forCellWithReuseIdentifier: PictureCollectionViewCell.identifier())
        collectionViewPictures.delegate = self
        collectionViewPictures.dataSource = self
        collectionViewPictures.isPagingEnabled = true
    }
    
    private func configureProductInfo(){
       lbTitleProduct.text = viewModel.title
        lbTitleProduct.adjustsFontSizeToFitWidth = true
       lbStatus.text = viewModel.status
       lbPageCurrent.text = (self.currentPageImg+1).description+"/"+viewModel.pictures().count.description
   }
    
    func setViewModel(vm: ViewModelProductDetail){
        self.viewModel = vm
        configureProductInfo()
        collectionViewPictures.reloadData()
    }

}


extension DetailProductPicturesCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.viewModel == nil){return 0}
        return self.viewModel.pictures().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell.identifier(), for: indexPath) as! PictureCollectionViewCell
        cell.setImageProduct(url: self.viewModel.pictures()[indexPath.row].url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 294)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentPageImg = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if currentPageImg == indexPath.row {
            currentPageImg = collectionView.indexPath(for: collectionView.visibleCells.first!)!.row
        }
    }
}
