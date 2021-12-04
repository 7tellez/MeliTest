//
//  HomeViewController.swift
//  Meli
//
//  Created by Cristian Tellez on 2/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate : class {
    func navigateToDetailProduct(id:String)
}

class HomeViewController: MELIViewController {
    
    // Variables
    weak var delegate : HomeViewControllerDelegate?
    var productsSearch : [Product] = [] {
        didSet{
            self.collectionView.reloadData()
        }
    }
    var initSearchText = "silla"
    var textSearch : String = "tecnologia" {
        didSet {
            initData()
        }
    }
    var isSearching : Bool = false {
        didSet{
            DispatchQueue.main.async {
                if (self.isSearching){
                    self.showLoader()
                }else{
                    self.hideLoader()
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    // Views
    weak var widthCancelBt : NSLayoutConstraint?
    weak var heightHeader : NSLayoutConstraint?
    let header : MELIView  = {
        let v = MELIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let content : MELIView = {
        let v = MELIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var push : UIRefreshControl = {
        let push = UIRefreshControl()
        push.addTarget(self, action: #selector(initData), for: .valueChanged)
        return push
    }()
    
    lazy var collectionView : MELICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumInteritemSpacing = 10
        let c = MELICollectionView(frame: .zero, collectionViewLayout: flow)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.keyboardDismissMode = .interactive
        c.showsVerticalScrollIndicator = false
        c.addSubview(push)
        return c
    }()
    
    lazy var searchCustomBar : MELITextField = {
        let t = MELITextField(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.createTextFieldSearch(placeHolder: "Buscar, productos, marcas y más...")
        t.returnKeyType = .search
        t.delegate = self
        return t
    }()
    
    let btCancel : MELIButton = {
        let b = MELIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Cancelar", for: .normal)
        b.addTarget(self, action: #selector(cancelSearch), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return b
    }()
    
    let loader : UIActivityIndicatorView = {
        let l = UIActivityIndicatorView(style: .whiteLarge)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.color = .black
        l.hidesWhenStopped = true
        l.startAnimating()
        return l
    }()
    
    lazy var btReloader : MELIButton = {
        let b = MELIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Reload", for: .normal)
        b.isHidden = true
        b.setTitleColor(.black, for: .normal)
        b.layer.borderColor = UIColor.black.cgColor
        b.layer.borderWidth = 1.2
        b.layer.cornerRadius = 15
        b.addTarget(self, action: #selector(initData), for: .touchUpInside)
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initCollection()
        initData()
    }
    
    // add constraints in views
    fileprivate func initViews(){
        self.view.backgroundColor = .groupTableViewBackground
        self.view.addSubview(header)
        self.view.addSubview(content)
        self.content.autoMarginView(subView: collectionView)
        self.header.addSubview(searchCustomBar)
        self.header.addSubview(btCancel)
        self.content.addSubview(loader)
        self.content.addSubview(btReloader)
        
        header.top(topAnchor: self.view.topAnchor, size: 0)
        header.left(leftAnchor: self.view.leftAnchor, size: 0)
        header.right(rightAnchor: self.view.rightAnchor, size: 0)
        heightHeader = header.height(size: 100)
        
        content.top(topAnchor: self.header.bottomAnchor, size: 0)
        content.left(leftAnchor: self.view.leftAnchor, size: 12)
        content.right(rightAnchor: self.view.rightAnchor, size: 12)
        content.bottom(bottomAnchor: self.view.bottomAnchor, size: 0)
        
        btCancel.right(rightAnchor: self.view.rightAnchor, size: 8)
        btCancel.centerY(vertical: searchCustomBar.centerYAnchor)
        btCancel.height(size: 40)
        widthCancelBt = btCancel.width(size: 0)
        
        searchCustomBar.left(leftAnchor: self.header.leftAnchor, size: 20)
        searchCustomBar.right(rightAnchor: self.btCancel.leftAnchor, size: 12)
        searchCustomBar.bottom(bottomAnchor: self.header.bottomAnchor, size: 10)
        searchCustomBar.height(size: 40)
        
        loader.centerY(vertical: content.centerYAnchor)
        loader.centerX(horizontal: content.centerXAnchor)
        loader.width(size: 30)
        loader.height(size: 30)
        
        btReloader.centerY(vertical: content.centerYAnchor)
        btReloader.centerX(horizontal: content.centerXAnchor)
        btReloader.width(size: 100)
        btReloader.height(size: 30)
    }
    
    // register delegates
    fileprivate func initCollection(){
        self.collectionView.register(ProductCollectionViewCell.loadNib(), forCellWithReuseIdentifier: ProductCollectionViewCell.identifier())
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .groupTableViewBackground
    }
    
    // init random products
    @objc fileprivate func initData(){
        btReloader.isHidden = true
        isSearching = true
        ProductService.searchProducts(by: self.textSearch) { [weak self](scc, prods, msg, pag) in
            if (!scc) {
                self?.showAlert(msg: msg ?? "Productos no encontrados", title: "Error Buscando Products")
                self?.showButtonReload()
            }
            DispatchQueue.main.async {
                self?.isSearching = false
                self?.productsSearch = prods
                self?.push.endRefreshing()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            heightHeader?.constant = 60
        default:
            heightHeader?.constant = 100
        }
        self.view.layoutIfNeeded()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func showLoader(){
        DispatchQueue.main.async {
            if (self.productsSearch.count == 0) {
                self.collectionView.isHidden = true
                self.loader.startAnimating()
            }
        }
    }
    func hideLoader(){
        DispatchQueue.main.async {
            self.collectionView.isHidden = false
            self.loader.stopAnimating()
        }
    }
    
    func showButtonReload(){
        if (self.productsSearch.count == 0) {
            btReloader.isHidden = false
        }
    }
}


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsSearch.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier(),
                                                       for: indexPath) as! ProductCollectionViewCell
        
        cell.isLoading = isSearching
        cell.setViewModel(vm: ViewModelProduct(product: productsSearch[indexPath.row]))
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width-24, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = ViewModelProduct(product: productsSearch[indexPath.row])
        self.delegate?.navigateToDetailProduct(id: viewModel.id)
    }
}



extension HomeViewController : UITextFieldDelegate {
    
    @objc func cancelSearch(){
        self.textSearch = initSearchText
        self.searchCustomBar.text = ""
        self.hideBtCancel()
        self.view.endEditing(true)
    }
    
    private func showBtCancel(){
        UIView.animate(withDuration: 0.3) {
            self.widthCancelBt?.constant = 80
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideBtCancel(){
        UIView.animate(withDuration: 0.3) {
            self.widthCancelBt?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showBtCancel()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.textSearch = textField.text ?? ""
        return true
    }
}
