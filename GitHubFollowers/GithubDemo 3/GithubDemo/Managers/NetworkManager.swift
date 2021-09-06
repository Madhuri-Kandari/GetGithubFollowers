//
//  NetworkManager.swift
//  GithubDemo
//
//  Created by M1066749 on 06/07/21.
//

import UIKit

class NetworkManager{
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() { }
    func getFollowers(for username:String, page:Int,completed:@escaping (Result<[Follower],NetworkError>) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        if !NetworkStatus.shared.isOn{
            completed(.failure(.unableTocomplete))
            return
        }else{
            print(" internet YES")
        }
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data,response,error in
            if let _ = error{
                completed(.failure(.unableTocomplete))
                return
            }
            
            guard let response = response as?HTTPURLResponse,response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            }
            catch{
                completed(.failure(.invalidPassing))
            }
            
        }
        task.resume()
        
    }
    
    func getUserInfo(for userName:String, completed: @escaping(Result<User,NetworkError>) -> Void){
        let endpoint = baseUrl + "\(userName)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data,response,error in
            if let _ = error{
                completed(.failure(.unableTocomplete))
                return
            }
            
            guard let response = response as?HTTPURLResponse,response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }
            catch{
                completed(.failure(.invalidPassing))
            }
            
        }
        task.resume()
        
    }
    }

