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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(displayedTopList: TopListModels.DisplayedTopList) {
        
        
        
        nameLbl.text = displayedTopList.name
        fullNameLbl.text = displayedTopList.fullName
        priceLbl.text = displayedTopList.price
        differentLbl.text = displayedTopList.priceChange
        differentLblContainer.backgroundColor = displayedTopList.isNegative ? .systemRed : .systemGreen
    }
    
}
