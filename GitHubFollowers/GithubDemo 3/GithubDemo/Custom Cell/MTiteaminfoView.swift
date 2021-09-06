//
//  MTiteaminfoView.swift
//  GithubDemo
//
//  Created by M1066749 on 09/07/21.
//

import UIKit

enum ItemInfoType{
    case repose, gists,followers,following
}

class MTItemInfoView:UIView{
    
    let symbolImageView = UIImageView()
    let titleLabel      = MTTittleLabel(textAlignment: .left, fontSize: 16)
    let countLabel      = MTTittleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 22),
            symbolImageView.heightAnchor.constraint(equalToConstant: 22),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(itemInfoType:ItemInfoType, withCount count:Int) {
        switch itemInfoType {
        case .repose:
            symbolImageView.image = UIImage(systemName: SFSymbols.publicRepo)
            titleLabel.text = ItemLabels.publicRepos
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.publicGist)
            titleLabel.text = ItemLabels.publicGists
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.follower)
            titleLabel.text = ItemLabels.followers
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = ItemLabels.following
        
        }
        
        countLabel.text = String(count)
    }
}
