//
//  EpisodesByPodcastTableViewCell.swift
//  Podcasted
//
//  Created by Ali Moussa on 24/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit

class EpisodesByPodcastTableViewCell: UITableViewCell {
    
    let appSharedDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var Label_EpisodePodcastName: UILabel!
    @IBOutlet weak var Label_EpisodePodcastLength: UILabel!
    @IBOutlet weak var Label_EpisodePodcastPublishedDate: UILabel!
    @IBOutlet weak var Button_PlayPodcast: UIButton!
    
    var cellDelegate: PodcastCellPlay?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTintColorForPlayButton()
    }
    
    @IBAction func Button_PlayPodcast(_ sender: Any) {
        cellDelegate?.onClickPlayPodcast(index: (index?.row)!)
    }
    
    func setupTintColorForPlayButton() {
        self.Button_PlayPodcast.tintColor = appSharedDelegate.loadAppTintUIColorFromUserDefaults()
    }
}
