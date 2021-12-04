//
//  DetailProductViewController.swift
//  Meli
//
//  Created by Cristian Tellez on 27/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import UIKit


protocol DetailProductViewControllerDelegate: class {
    func backToHome()
}


class DetailProductViewController: MELIViewController {
    
    weak var delegate : DetailProductViewControllerDelegate?
    var idProductDetail:String
    enum EnumSection : String, CaseIterable{
        case picture = "Imagenes"
        case info = "Información"
        case price = "Precio"
    }

    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if (self.isLoading){
                    self.showLoader()
                }else{
                    self.hideLoader()
                    self.labelTitle.text = self.viewModelProdDetail?.title
                }
                self.tableView.reloadData()
            }
        }
    }
    var viewModelProdDetail : ViewModelProductDetail?
    var viewModelProdDescription : ViewModelProductDescription?
    var heightHeader : NSLayoutConstraint?
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
    
    let tableView : MELITableView = {
        let t = MELITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    let loader : UIActivityIndicatorView = {
        let l = UIActivityIndicatorView(style: .whiteLarge)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.color = .black
        l.hidesWhenStopped = true
        l.startAnimating()
        return l
    }()
    
    let btVoltar : MELIButton = {
        let b = MELIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        b.setImage(UIImage(named: "back"), for: .normal)
        return b
    }()
    let labelTitle : MELILabel = {
        let l = MELILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.boldSystemFont(ofSize: 11)
        return l
    }()
    
    // Init Inject Dependency
    init(product id:String){
        self.idProductDetail = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initViews()
        self.initTableView()
        self.initData()
    }
    
    
    @objc fileprivate func closeView(){
        self.delegate?.backToHome()
    }

    fileprivate func initViews(){
        self.view.backgroundColor = .groupTableViewBackground
        self.view.addSubview(header)
        self.view.addSubview(content)
        self.header.addSubview(btVoltar)
        self.header.addSubview(labelTitle)
        self.content.autoMarginView(subView: tableView)
        self.content.addSubview(loader)
        
        header.top(topAnchor: self.view.topAnchor, size: 0)
        header.left(leftAnchor: self.view.leftAnchor, size: 0)
        header.right(rightAnchor: self.view.rightAnchor, size: 0)
        heightHeader = header.height(size: 80)
        
        btVoltar.left(leftAnchor: header.leftAnchor, size: 8)
        btVoltar.bottom(bottomAnchor: header.bottomAnchor, size: 0)
        btVoltar.height(size: 44)
        btVoltar.width(size: 44)
        
        labelTitle.left(leftAnchor: btVoltar.rightAnchor, size: 4)
        labelTitle.right(rightAnchor: header.rightAnchor, size: 56)
        labelTitle.centerY(vertical: btVoltar.centerYAnchor)
        
        content.top(topAnchor: self.header.bottomAnchor, size: 0)
        content.left(leftAnchor: self.view.leftAnchor, size: 12)
        content.right(rightAnchor: self.view.rightAnchor, size: 12)
        content.bottom(bottomAnchor: self.view.bottomAnchor, size: 0)
        
        loader.centerY(vertical: content.centerYAnchor)
        loader.centerX(horizontal: content.centerXAnchor)
        loader.width(size: 30)
        loader.height(size: 30)
    }
    
    fileprivate func initTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(DetailProductPicturesCell.loadNib(), forCellReuseIdentifier: DetailProductPicturesCell.identifier())
        self.tableView.register(DetailProductDescriptionCell.loadNib(), forCellReuseIdentifier: DetailProductDescriptionCell.identifier())
        self.tableView.tableFooterView = UIView()
        self.tableView.showsVerticalScrollIndicator = false
    }
    
    fileprivate func initData(){
        self.isLoading = true
        ProductDetailService.getDetailProduct(product: self.idProductDetail) { [weak self](scc, product, msg) in
            if (!scc || product == nil){
                self?.showAlert(msg: msg ?? "Product not found", title: "Ops")
            }else if (scc){
                guard let prod = product else {return}
                self?.viewModelProdDetail = ViewModelProductDetail(product: prod)
            }
            self?.isLoading = false
        }
        
        ProductDetailService.getDescriptionProduct(product: self.idProductDetail) {[weak self] (scc, prod, msg) in
                guard let prod = prod else {return}
                self?.viewModelProdDescription = ViewModelProductDescription(product: prod)
        }
    }
    
    func showLoader(){
        self.tableView.isHidden = true
        self.loader.startAnimating()
    }
    func hideLoader(){
        self.loader.stopAnimating()
        self.tableView.isHidden = false
    }
  
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       switch UIDevice.current.orientation {
       case .landscapeLeft, .landscapeRight:
           heightHeader?.constant = 60
       default:
           heightHeader?.constant = 100
       }
       self.view.layoutIfNeeded()
        self.tableView.reloadData()
   }
}


extension DetailProductViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return EnumSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch EnumSection.allCases[indexPath.section] {
        case .picture:
            return 390
        case .info:
            return heightForLabelText(text: viewModelProdDescription?.text ?? "")
        case .price:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch EnumSection.allCases[indexPath.section] {
        case .picture:
            return createCellPicture(index: indexPath, tableView: tableView)
        case .info:
            return createCellInfo(index: indexPath, tableView: tableView)
        case .price:
            return creteCellPrice(index: indexPath, tableView: tableView)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return EnumSection.allCases[section].rawValue
    }
    
    private func createCellPicture(index:IndexPath, tableView:UITableView)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailProductPicturesCell.identifier()) as! DetailProductPicturesCell
        guard let pr = self.viewModelProdDetail else {return cell}
        cell.setViewModel(vm: pr)
        return cell
    }
    
    private func createCellInfo(index:IndexPath, tableView:UITableView)->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailProductDescriptionCell.identifier()) as! DetailProductDescriptionCell
        cell.lbDescription.text = viewModelProdDescription?.text
        return cell
    }
    
    private func creteCellPrice(index:IndexPath, tableView:UITableView)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailProductDescriptionCell.identifier()) as! DetailProductDescriptionCell
        cell.lbDescription.text = viewModelProdDetail?.price()
        cell.lbDescription.adjustsFontSizeToFitWidth = true
        cell.lbDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.lbDescription.textAlignment = .left
        cell.lbDescription.font = UIFont.boldSystemFont(ofSize: 22)
        return cell
    }
    
    private func heightForLabelText(text: String) -> CGFloat {

        let size = CGSize(width: view.frame.width - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height

        return rectangleHeight
    }
}
