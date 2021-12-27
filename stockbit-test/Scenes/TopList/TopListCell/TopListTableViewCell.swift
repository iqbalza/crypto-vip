//
//  TopListTableViewCell.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import UIKit

class TopListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var differentLbl: UILabel!
    @IBOutlet weak var differentLblContainer: UIView! {
        didSet {
            differentLblContainer.layer.cornerRadius = 3
            differentLbl.layer.masksToBounds = true
        }
    }
    static let identifier = "TopListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(displayedTopList: TopListModels.DisplayedTopList) {
        nameLbl.text = displayedTopList.name
        fullNameLbl.text = displayedTopList.fullName
        
        guard !displayedTopList.hasEmptyPrice,
              let price = displayedTopList.price,
              let priceChange = displayedTopList.priceChange,
              let isNegative = displayedTopList.isNegative
        else
            {
                differentLblContainer.backgroundColor = .gray
                priceLbl.text = "-"
                differentLbl.text = "-"
                return
            }
        
        priceLbl.text = price
        differentLbl.text = priceChange
        differentLblContainer.backgroundColor = isNegative ? .systemRed : .systemGreen
    }
    
}
