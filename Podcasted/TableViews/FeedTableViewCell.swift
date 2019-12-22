//
//  FeedTableViewCell.swift
//  Podcasted
//
//  Created by Ali Moussa on 19/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit

protocol PodcastCellPlay {
    func onClickPlayPodcast(index: Int)
}

class FeedTableViewCell: UITableViewCell {
    
    let appSharedDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var ImageView_PodcastIcon: UIImageView!
    @IBOutlet weak var Label_EpisodeName: UILabel!
    @IBOutlet weak var Label_PodcastName: UILabel!
    @IBOutlet weak var Label_PodcastLength: UILabel!
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
