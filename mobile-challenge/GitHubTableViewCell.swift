//
//  GitHubTableViewCell.swift
//  mobile-challenge
//
//  Created by Rodrigo Eduardo Silva on 21/03/22.
//

import UIKit
import Kingfisher

class GitHubTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbNameRepository: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbforks: UILabel!
    @IBOutlet weak var lbstars: UILabel!
    
    @IBOutlet weak var lbsuerName: UILabel!
    @IBOutlet weak var lbAvatar: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func prepareCell(with repo : GitHubInfo) {
        lbNameRepository.text = repo.name
        lbstars.text = String(repo.stargazers_count)
        lbforks.text = String(repo.forks)
        lbDescription.text = repo.description
        lbsuerName.text = repo.owner.login
        
        if let url = URL(string: repo.owner.avatar_url){
            
            lbAvatar.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
        }else{
            lbAvatar.image = nil
        }
        
    }

}
