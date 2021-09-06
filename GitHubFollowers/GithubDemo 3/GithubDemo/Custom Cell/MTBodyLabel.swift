//
//  MTBodyLabel.swift
//  GithubDemo
//
//  Created by M1066749 on 05/07/21.
//

import UIKit

class MTBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init (textAlignment:NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        lineBreakMode = .byWordWrapping
        
    }

}
