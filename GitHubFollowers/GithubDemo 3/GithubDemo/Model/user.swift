//
//  user.swift
//  GithubDemo
//
//  Created by M1066749 on 06/07/21.
//

import Foundation

struct User:Codable {
    let login:String
    let avatarUrl:String
    var name:String?
    var location:String?
    var bio:String?
    let publicRepos:Int
    let publicGists:Int
    let followers:Int
    let following:Int
    let htmlUrl:String
    let createdAt:String
}
