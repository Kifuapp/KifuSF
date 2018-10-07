//
//  KFVImage.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVImage: UIView, Configurable {

    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        configureStyling()
        configureLayoutConstraints()
    }
    
    func configureLayoutConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.autoPinEdgesToSuperviewEdges()
    }
    
    func configureStyling() {
        //TODO: decide on the shadow
        backgroundColor = UIColor.clear
        imageView.clipsToBounds = true
        
        imageView.layer.cornerRadius = CALayer.kfCornerRadius
        imageView.contentMode = .scaleAspectFill
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
