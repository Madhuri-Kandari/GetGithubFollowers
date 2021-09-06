//
//  MTButton.swift
//  GithubDemo
//
//  Created by M1066749 on 05/07/21.
//

import UIKit

class MTButton: UIButton {
    
    override init(frame: CGRect) {
           super.init(frame: frame)
       }
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       init(bgColor:UIColor,title:String){
           super.init(frame: .zero)
           self.backgroundColor = bgColor
           self.setTitle(title, for: .normal)
           configure()
       }
      private func configure(){
           translatesAutoresizingMaskIntoConstraints = false
           layer.cornerRadius = 10
           titleLabel?.textColor = .white
           titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
           
       }

   }
