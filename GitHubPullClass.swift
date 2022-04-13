//
//  GitHubPullClass.swift
//  mobile-challenge
//
//  Created by Rodrigo Eduardo Silva on 04/04/22.
//

import Foundation


struct Pull : Codable {
var pullRequest : [PullRequest]
  
}

struct PullRequest : Codable {
    var title : String
    var user : User
    
}

struct User : Codable {
    
    var avatar_url : String
    var body: String?
    
    
    
}
