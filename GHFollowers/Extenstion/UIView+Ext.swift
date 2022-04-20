//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Ahmed Nagy on 16/04/2022.
//

import UIKit


extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {addSubview(view)}
    }
    
    
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
