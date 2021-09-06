//
//  ViewController.swift
//  GithubDemo
//
//  Created by M1066749 on 05/07/21.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
       let usernameTextField = MTTextField()
       let searchButton = MTButton(bgColor: .systemGreen, title: "Get Followers")
       
       var isUserNameEntered: Bool{ return !usernameTextField.text!.isEmpty}
       
       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .systemBackground
           //create th UI
           configureLogoImageView()
           configureTextField()
           configureSearchButton()
           createDismisKeyBoardGesture()
           
       }
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.isNavigationBarHidden = true
        
       }
       func createDismisKeyBoardGesture(){
           let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
           view.addGestureRecognizer(tap)
       }
       func configureLogoImageView(){
           view.addSubview(logoImageView)
           logoImageView.translatesAutoresizingMaskIntoConstraints = false
           logoImageView.image = UIImage(named: "gh-logo")!
           NSLayoutConstraint.activate([
               logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 80),
               logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               logoImageView.heightAnchor.constraint(equalToConstant: 200),
               logoImageView.widthAnchor.constraint(equalToConstant: 200)
               
           ])
       }
       func configureTextField(){
           view.addSubview(usernameTextField)
        usernameTextField.delegate = self
           NSLayoutConstraint.activate([
               usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
               usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
               usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
               usernameTextField.heightAnchor.constraint(equalToConstant: 48)
           ])
       }
       func configureSearchButton(){
           view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
           NSLayoutConstraint.activate([
               searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
               searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
               searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
               searchButton.heightAnchor.constraint(equalToConstant: 48)
           ])
       }
    
    @objc func pushFollowersListVC(){
        guard isUserNameEntered else {
         presentMTAlertOnMain(title: "Error", message: "no user entered", buttonTitle: "enter again")
            return
        }
        let followerListVc = FollowerListVC()
        followerListVc.userName = usernameTextField.text
        followerListVc.title = usernameTextField.text
        navigationController?.pushViewController(followerListVc, animated: true)
        
    }

   }

extension SearchVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}
