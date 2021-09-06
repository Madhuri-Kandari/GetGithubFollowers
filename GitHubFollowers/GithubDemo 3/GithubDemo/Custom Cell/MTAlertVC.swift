//
//  MTAlertVC.swift
//  GithubDemo
//
//  Created by M1066749 on 05/07/21.
//

import UIKit

class MTAlertVC: UIViewController {
    let containerView = UIView()
    let titleLabel  = MTTittleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = MTBodyLabel(textAlignment: .center)
    let actionButton = MTButton(bgColor: .systemPink, title: "Ok")
    
    var alertTitle:String?
    var message:String?
    var buttonTitle:String?
    
    var padding:CGFloat = 20
    
    init(title:String,message:String,buttonTitle:String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
}
    
    func configureContainerView(){
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        containerView.widthAnchor.constraint(equalToConstant: 200),
        containerView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
           titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: padding),
           titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
           titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
           titleLabel.heightAnchor.constraint(equalToConstant: 28)])
    }
    
    func configureActionButton(){
        containerView.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        if let title = buttonTitle{
            actionButton.setTitle(title, for: .normal)
        }
        NSLayoutConstraint.activate([
        actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant:-padding),
        actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
        actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
        actionButton.heightAnchor.constraint(equalToConstant: 40)])
        
    }
    
    func configureMessageLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor,constant: -8)
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
