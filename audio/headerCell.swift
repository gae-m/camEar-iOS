//
//  headerCell.swift
//  audio
//
//  Created by Gaetano Martedì on 30/06/18.
//  Copyright © 2018 iOS Foundation. All rights reserved.
//

import UIKit

class headerCell: UICollectionReusableView {
        
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBAction func buttonSegue() {
        nvTitle = headerTitle.text
    }
}
