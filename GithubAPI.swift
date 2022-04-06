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
    static private let per_page = 30
    
    
    class func loadRepositories( page: Int , language: String ,onComplete: @escaping (GitHead?) -> Void ){

        let url = basePath + "q=language:\(language)&sort=stars&page=\(page)&per_page=\(per_page)"
        let headers: HTTPHeaders = [
            "Authorization": "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",
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
    
    class func loadPulls(owner : String , repo : String , onComplete : @escaping (Pull?) -> Void){
        let url = "https://api.github.com/repos/\(owner)/\(repo)/pulls"
        let headers : HTTPHeaders = [
            "Authorization": "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",
            "Accept": "application/json"
          ]
        AF.request(url,headers: headers).responseDecodable(of: Pull.self) { response in
               guard let data = response.data,
                  let githubpull = try? JSONDecoder().decode(Pull.self, from: data)else{
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
