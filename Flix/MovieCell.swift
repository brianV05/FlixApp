//
//  MovieCell.swift
//  Flix
//
//  Created by Brian Velecela on 2/10/22.
//

import UIKit

class MovieCell: UITableViewCell {
    
    //add all outlet for the Custom View Table Cell
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
