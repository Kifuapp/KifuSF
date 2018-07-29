//
//  VolunteerCell.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit

class VolunteerCell: UITableViewCell {
    
    weak var delegate: VolunteerCellDelegate?

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        delegate?.confirmButtonTapped(cell: self)
    }
}

protocol VolunteerCellDelegate: class {
    func confirmButtonTapped(cell: VolunteerCell)
}
