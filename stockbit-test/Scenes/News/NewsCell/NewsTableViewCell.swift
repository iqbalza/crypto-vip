//
//  NewsTableViewCell.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    
    static let identifier = "NewsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(displayedNews: NewsModels.DisplayedNews) {
        sourceLbl.text = displayedNews.source
        titleLbl.text = displayedNews.title
        bodyLbl.text = displayedNews.body
    }
    
}
