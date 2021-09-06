//
//  MTSecondaryTitlelabel.swift
//  GithubDemo
//
//  Created by M1066749 on 08/07/21.
//

import UIKit

class MTSecondaryTitlelabel: UILabel {

    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byTruncatingTail
    }
}
