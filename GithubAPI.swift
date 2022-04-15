//
//  GithubAPI.swift
//  mobile-challenge
//
//  Created by Rodrigo Eduardo Silva on 20/03/22.
//

import Foundation
import Alamofire

class GithubAPI {
    
    static private let basePath = "https://api.github.com/search/repositories?"
    static private let teste = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"
    static private let privateToken = "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"
    static private let per_page = 50
    
    
    class func loadRepositories( page: Int , language: String ,onComplete: @escaping (GitHead?) -> Void ){

        let url = basePath + "q=language:\(language)&sort=stars&page=\(page)&per_page=\(per_page)"
        let headers: HTTPHeaders = [
            "Authorization": "\(privateToken)",
            "Accept": "application/json"
        ]
        print(url)
        AF.request(url,headers: headers).responseDecodable(of: GitHead.self) { response in
            
               guard let data = response.data,
                  let githubinfo = try? JSONDecoder().decode(GitHead.self, from: data)else{
                  onComplete(nil)
                      print("deu ruim")
                    
                      print(response.error as Any)
                      
                return
            }
            onComplete(githubinfo)
            
        }
    }
    
    class func loadPulls( pullpage: Int , owner : String , repo : String , onComplete : @escaping ([PullRequest]?) -> Void){
        let url = "https://api.github.com/repos/\(owner)/\(repo)/pulls?page=\(pullpage)&per_page=25"
        let headers : HTTPHeaders = [
            "Authorization": "\(privateToken)",
            "Accept": "application/json"
          ]
        AF.request(url,headers: headers).responseDecodable(of: [PullRequest].self) { response in
               guard let data = response.data,
                  let githubpull = try? JSONDecoder().decode([PullRequest].self, from: data)else{
                   onComplete(nil)
                      print("deu ruim")
                      print(response.error as Any)
                      print(url)
                return
            }
            onComplete(githubpull)
            
        }

        
    }
    

    
}
