//
//  FollowerListVCViewController.swift
//  GithubDemo
//
//  Created by M1066749 on 05/07/21.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section{
        case main
    }
    
    var userName:String!
    var followers:[Follower] = []
    var filteredFollowers:[Follower] = []
    
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView:UICollectionView!
    var dataSource:UICollectionViewDiffableDataSource<Section,Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureSearchController()
       getFollowers(username: userName, page: page)
        configureDataSource()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout() )
        collectionView.backgroundColor = .systemGray
        view.addSubview(collectionView)
        collectionView.delegate = self
        //collectionView.backgroundColor = .systemBlue
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reused)
    }
    
    func configureSearchController(){
        let searchController  = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a Username"
        navigationItem.searchController = searchController
    
       // navigationItem.searchController = nil
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minimumItemSpacing:CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth/3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    func getFollowers(username:String,page:Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: 1){ [weak self] result in
            guard let self = self else {return}

            self.hideLoadingView()
        switch result{
            case .success(let followers):
                if followers.count<100{
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf:followers)
                
                if self.followers.isEmpty{
                    let message = "\(username) doesnt have any followers. Please help him 🥺."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                }
                self.updateData(on: followers)
            case .failure(let errorMessage):
            self.presentMTAlertOnMain(title: "Error", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView,indexpath,follower in
            //let position = indexpath.row
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reused, for: indexpath) as! FollowerCell
                cell.set(follower:follower)
            return cell
        
        })
    }
    
    func updateData(on followerList:[Follower]){
        //create the snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        //initialize the data
        snapshot.appendSections([.main])
        snapshot.appendItems(followerList)
        //apply the data
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
        
    }
}
extension FollowerListVC:UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        //print("offsetY is \(offsetY) contentHeight is \(contentHeight) height is \(height)")
        //to get the next set of data we uses below equation
        if offsetY > contentHeight - height{
            guard hasMoreFollowers else{
                return
            }
             page += 1
            getFollowers(username:userName,page:page)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArry = isSearching ? filteredFollowers : followers
        let follower = activeArry[indexPath.item]
        
        let destVC = UserinfoVC()
        destVC.username = follower.login
        destVC.modalPresentationStyle = .overFullScreen
        destVC.modalTransitionStyle = .flipHorizontal//.crossdisolve
        let navigationController = UINavigationController(rootViewController: destVC)
        present(navigationController,animated: true)
        //self.navigationController?.pushViewController(destVC, animated: true)
    }
}

extension FollowerListVC:UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,!searchText.isEmpty else{return}
        isSearching = true
        filteredFollowers = followers.filter{$0.login.lowercased().contains(searchText.lowercased())}
       updateData(on: filteredFollowers)
    
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}


