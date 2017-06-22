//
//  Custom.swift
//  test2
//
//  Created by Bhavin on 10/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class Custom: UITableViewCell {

    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var videoArea: UIWebView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
