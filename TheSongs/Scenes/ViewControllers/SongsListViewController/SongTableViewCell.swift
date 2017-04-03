//
//  SongTableViewCell.swift
//  TheSongs
//
//  Created by PikaDot on 4/2/17.
//  Copyright © 2017 Midhun P Mathew. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songTitleLabel : UILabel!
    @IBOutlet weak var songWriterLabel: UILabel!
    @IBOutlet weak var coverImageView : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
