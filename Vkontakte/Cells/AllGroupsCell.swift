//
//  AllGroupsCell.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 18.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import UIKit

class AllGroupsCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
