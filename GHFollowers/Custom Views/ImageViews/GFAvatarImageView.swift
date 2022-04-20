//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Ahmed Nagy on 13/04/2022.
//

import UIKit


class GFAvatarImageView: UIImageView {
    
    let cashe = NetworkManager.shared.cashe
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from URLString: String) {
        
        let casheKey = NSString(string: URLString)
        
        if let image = cashe.object(forKey: casheKey) {
            self.image = image
            return
        }
        
        guard let URL = URL(string: URLString) else { return }
        
        let _ = URLSession.shared.dataTask(with: URL) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {  return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cashe.setObject(image, forKey: casheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
