//
//  MELITextField.swift
//  Meli
//
//  Created by Cristian Tellez on 26/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import UIKit

class MELITextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    func createTextFieldSearch(placeHolder text:String, height:CGFloat = 40){
        self.layer.cornerRadius = height/2
        
        let iconSearch = UIImageView(frame: CGRect(x: 15, y: 5, width: 20, height: height-10))
        iconSearch.image = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        iconSearch.tintColor = .groupTableViewBackground
        iconSearch.contentMode = .scaleAspectFit
        
        let content = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: height))
        content.addSubview(iconSearch)
        
        self.leftView = content
        self.leftViewMode = .always
        
        self.placeholder = text
        self.backgroundColor = .white
        
        self.font = UIFont.boldSystemFont(ofSize: 13)
    }
    

}
