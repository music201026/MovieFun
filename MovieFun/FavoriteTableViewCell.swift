//
//  FavoriteTableViewCell.swift
//  AlamoFireDemo
//
//  Created by Bowz on 2020/06/15
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
