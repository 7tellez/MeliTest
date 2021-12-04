//
//  DetailProductDescriptionCell.swift
//  Meli
//
//  Created by Cristian Tellez on 27/11/19.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import UIKit

class DetailProductDescriptionCell: UITableViewCell {

    
    @IBOutlet weak var lbDescription: UILabel!
    static func loadNib()->UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    static func identifier()->String{
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
