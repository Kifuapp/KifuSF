//
//  ItemPostCell.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit

class ItemPostCell: UITableViewCell {

    weak var delegate: ItemPostCellDelegate?
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var postInfo: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func requestButtonTapped(_ sender: Any) {
        delegate?.requestButtonTapped(cell: self)
    }
}

protocol ItemPostCellDelegate: class {
    func requestButtonTapped(cell: ItemPostCell)
}
