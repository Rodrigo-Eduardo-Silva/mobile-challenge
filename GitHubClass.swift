//
//  GitHubClass.swift
//  mobile-challenge
//
//  Created by Rodrigo Eduardo Silva on 20/03/22.
//

import Foundation

struct GitHead : Codable {
    let total_count : Int
    let items : [GitHubInfo]
}

struct GitHubInfo : Codable{
    let id : Int
    let name: String
    let full_name: String
    let stargazers_count : Int
    let forks: Int
    let description: String?
    let owner : Owner

}

struct Owner : Codable{
    let login : String
    let id : Int
    let avatar_url : String
    let repos_url : String
    
}



    
    
    

