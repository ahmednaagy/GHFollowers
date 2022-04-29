//
//  FavoritesListViewController.swift
//  GHFollowers
//
//  Created by Ahmed Nagy on 04/12/2021.
//

import UIKit

class FavoritesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        PersistenceManager.retrieveFavorites { result in
            switch result {
                
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }
 

}
