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
    
    weak var delegate: KFVImageDelegate?
    
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
        backgroundColor = UIColor.clear
        imageView.clipsToBounds = true
        
        imageView.layer.cornerRadius = CALayer.kfCornerRadius
        imageView.contentMode = .scaleAspectFill
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
    @objc private func imageTapped() {
        delegate?.didSelect(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol KFVImageDelegate: class {
    func didSelect(_ imageView: KFVImage)
}
