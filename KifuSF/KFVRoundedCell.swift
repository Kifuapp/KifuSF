//
//  KFVRoundedCell.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 09/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVRoundedCell<T: UIDescriptorView>: UITableViewCell, UIConfigurable {
    let descriptorView = T()
    
    static var identifier: String {
        return String(describing: T.self)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(descriptorView)
        
        configureStyling()
        configureLayout()
    }
    
    func configureLayout() {
        configureDescriptorViewLayoutConstraints()
    }
    
    func configureStyling() {
        self.selectionStyle = .none
        layer.masksToBounds = false
        contentView.backgroundColor = UIColor.kfGray
    }
    
    func configureDescriptorViewLayoutConstraints() {
        descriptorView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptorView.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        descriptorView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        descriptorView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        descriptorView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        descriptorView.backgroundColor = selected ? .kfHighlight : .kfSuperWhite
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        descriptorView.backgroundColor = highlighted ? .kfHighlight : .kfSuperWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
