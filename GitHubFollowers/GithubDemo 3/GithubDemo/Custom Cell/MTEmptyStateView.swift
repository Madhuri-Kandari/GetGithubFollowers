//
//  MTEmptyStateView.swift
//  GithubDemo
//
//  Created by M1066749 on 07/07/21.
//

import UIKit

class MTEmptyStateView: UIView {

    let messageLabel = MTTittleLabel(textAlignment: .center, fontSize: 32)
    let logoImageView = UIImageView()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message:String){
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    private func configure(){
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -180),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 160),
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -40)
        ])
    }
    
}
