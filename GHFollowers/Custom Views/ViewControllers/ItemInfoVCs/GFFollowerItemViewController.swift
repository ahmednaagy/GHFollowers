//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Ahmed Nagy on 26/04/2022.
//

import UIKit

class GFFollowerItemViewController: GFItemInfoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
}
