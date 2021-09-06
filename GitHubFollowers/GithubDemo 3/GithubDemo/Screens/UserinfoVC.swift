//
//  UserinfoVC.swift
//  GithubDemo
//
//  Created by M1066749 on 08/07/21.
//

import UIKit

class UserinfoVC: UIViewController {

    var username:String!
    let itemViewOne:UIView = UIView()
    let itemViewTwo:UIView = UIView()
    var headerView:UIView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getUserInfo()
        setupLayout()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVc))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username){
            [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: MTUserinfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentMTAlertOnMain(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func setupLayout(){
        let padding:CGFloat = 20
        let iteamHeight:CGFloat = 160
        
        let itemViews:[UIView] = [headerView,itemViewOne,itemViewTwo]
        
        for itemview in itemViews{
        view.addSubview(itemview)
        itemview.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                itemview.trailingAnchor.constraint(equalTo: view.trailingAnchor),])
        }
        

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: iteamHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: iteamHeight)
            
        ])
    }
    
    func add(childVC:UIViewController,to containerView:UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    @objc func dismissVc(){
        dismiss(animated: true)
    }

}
