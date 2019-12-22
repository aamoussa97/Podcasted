//
//  SavedPodcastsCollectionViewCell.swift
//  Podcasted
//
//  Created by Ali Moussa on 25/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit

class SavedPodcastsCollectionViewCell: UICollectionViewCell {
    
    var ImageView_PodcastIcon = UIImageView()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        ImageView_PodcastIcon = UIImageView(frame: self.bounds)
        contentView.addSubview(ImageView_PodcastIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
