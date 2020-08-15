//
//  TableViewCell.swift
//  Task
//
//  Created by Rohini Deo on 12/08/20.
//  Copyright © 2020 Taxgenie. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //Mark:IBOutlet:
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
