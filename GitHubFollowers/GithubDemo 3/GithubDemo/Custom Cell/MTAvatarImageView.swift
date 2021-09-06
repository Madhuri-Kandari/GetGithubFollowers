//
//  MTAvatarImageView.swift
//  GithubDemo
//
//  Created by M1066749 on 06/07/21.
//

import UIKit

class MTAvatarImageView: UIImageView {
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    let cache = NetworkManager.shared.cache
    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }
    
    func downloadImage(from urlString:String){
        let cacheKey = NSString(string: urlString)
        guard let url = URL(string: urlString) else{return}
        //check if it is cached or not
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data,resonse,error in
            guard let self = self else {return}
            if error != nil {return}
            guard let response = resonse as? HTTPURLResponse, response.statusCode == 200 else{return}
            guard let data = data else{return}
            guard let image = UIImage(data: data) else { return}
            //store the image in cache
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
