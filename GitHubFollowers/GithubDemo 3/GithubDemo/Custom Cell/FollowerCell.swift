//
//  FollowerCell.swift
//  GithubDemo
//
//  Created by M1066749 on 06/07/21.
//

import UIKit

class FollowerCell:UICollectionViewCell{
    static let reused = "FollowerCell"
    let avatarImageView = MTAvatarImageView(frame: .zero)
     let usernameLabel = MTTittleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        let padding:CGFloat = 8
        NSLayoutConstraint.activate([
        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: padding),
        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: padding),
        avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding),
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
        usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: 12),
        usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: padding),
        usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding),
        usernameLabel.heightAnchor.constraint(equalToConstant: 20)])
    }

func set(follower:Follower){
    usernameLabel.text = follower.login
    //#warning("downloadimage")
    avatarImageView.downloadImage(from: follower.avatarUrl)
}
}
