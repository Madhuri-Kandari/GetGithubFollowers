//
//  ErrorMessage.swift
//  GithubDemo
//
//  Created by M1066749 on 06/07/21.
//

import Foundation

enum NetworkError:String,Error{
    case invalidUserName = "This username created an invalid request, please try again."
    case unableTocomplete = "Unable to complete your request.Please check your internet connection"
    case invalidResponse = "invalid response from the server. please try again."
    case invalidData = "Data received from server is invalid.please try again."
    case invalidPassing = "data received from server is invalid.please try again."
}
