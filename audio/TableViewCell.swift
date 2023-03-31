//
//  TableViewCell.swift
//  audio
//
//  Created by Gaetano Martedì on 02/07/18.
//  Copyright © 2018 iOS Foundation. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titolo: UILabel!
    @IBOutlet weak var dettaglio: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
