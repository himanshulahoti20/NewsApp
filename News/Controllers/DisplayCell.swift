//
//  DisplayCell.swift
//  News
//
//  Created by Himanshu Lahoti on 07/07/22.
//

import UIKit

class DisplayCell: UITableViewCell {
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblNewsSource: UILabel!
    @IBOutlet weak var imgNewsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(newsTitle : String , newsSource : String){
        self.lblNewsTitle.text = newsTitle
        self.lblNewsSource.text = newsSource
    }
    
}

