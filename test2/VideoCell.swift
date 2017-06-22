//
//  VideoCell.swift
//  test2
//
//  Created by Bhavin on 09/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var playArea: UIWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
