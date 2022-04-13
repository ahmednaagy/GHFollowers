//
//  GFAlertContainerView.swift
//  GHFollowers
//
//  Created by Ahmed Nagy on 07/04/2022.
//

import UIKit

class GFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 0.6
        layer.borderColor = UIColor.white.cgColor
    }


}
