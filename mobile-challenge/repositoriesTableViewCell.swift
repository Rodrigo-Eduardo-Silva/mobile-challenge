//
//  repositoriesTableViewCell.swift
//  mobile-challenge
//
//  Created by Rodrigo Eduardo Silva on 21/03/22.
//

import UIKit
import Kingfisher

class repositoriesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivAvatar: UIImageView!
    
    @IBOutlet weak var LbBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCellPull(with pulls : PullRequest) {
        lbTitle.text = pulls.title
        if let bodyPull = pulls.user.body {
            LbBody.text = bodyPull
        }else{
            LbBody.text = "Just a PullRequest Body"
        }
    
        
        if let url = URL(string: pulls.user.avatar_url){
            ivAvatar.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
       }else{
            ivAvatar.image = nil
       }
    }

}
