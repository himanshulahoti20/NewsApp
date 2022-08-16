//
//  NewsCell.swift
//  News
//
//  Created by Himanshu Lahoti on 07/07/22.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(newsTitle : String , newsSource : String){
        self.newsTitle.text = newsTitle
        self.newsSource.text = newsSource
    }
    
}
