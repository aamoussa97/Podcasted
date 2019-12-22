//
//  QueueEpisodesTableViewCell.swift
//  Podcasted
//
//  Created by Ali Moussa on 11/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit

class QueueEpisodesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ImageView_EpisodeIcon: UIImageView!
    @IBOutlet weak var Label_EpisodeName: UILabel!
    @IBOutlet weak var Label_EpisodeDate: UILabel!
    @IBOutlet weak var Label_EpisodeTimeRemaining: UILabel!
    
 override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
