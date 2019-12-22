//
//  SearchTableViewCell.swift
//  Podcasted
//
//  Created by Ali Moussa on 25/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit

protocol PodcastCellSave {
    func onClickAddPodcast(index: Int)
}

class SearchTableViewCell: UITableViewCell {
    
    let appSharedDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var Label_PodcastName: UILabel!
    @IBOutlet weak var ImageView_PodcastIcon: UIImageView!
    @IBOutlet weak var Button_AddPodcastToSaved: UIButton!
    
    var cellDelegate: PodcastCellSave?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTintColorForPlayButton()
    }
    
    @IBAction func Button_AddPodcastToSaved(_ sender: Any) {
        cellDelegate?.onClickAddPodcast(index: (index?.row)!)
    }
    
    func setupTintColorForPlayButton() {
        self.Button_AddPodcastToSaved.tintColor = appSharedDelegate.loadAppTintUIColorFromUserDefaults()
    }
    
}
