//
//  FeedEpisodesFilterVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 14/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import BottomPopup

class FeedEpisodesFilterVC: BottomPopupViewController {
    
    var currenetSelectedSortOption: SortByFeed?
    
    let appSharedDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubViews()
    }
    
    func setupView() {
        self.view.backgroundColor = .systemBackground
    }
    
    func addSubViews() {
        // Set tintColor from UserDefaults
        let appTintUIColorFromUserDefaults = appSharedDelegate.loadAppTintUIColorFromUserDefaults()
        
        // ImageView - For: Sort By
        let sortByIcon = UIImageView(image: UIImage(systemName: "arrow.up.arrow.down"))
        sortByIcon.frame = CGRect(x: 20, y: 50, width: 25, height: 20)
        sortByIcon.tintColor = appTintUIColorFromUserDefaults
        self.view.addSubview(sortByIcon)
        
        // Button - For: Sort By Episode Name
        let sortByButton = UIButton(frame: CGRect(x: 60, y: 35, width: self.view.frame.width-20, height: 50))
        //sortByEpisodeNameButton.layer.cornerRadius = 10
        sortByButton.setTitle("Sort By", for: .normal)
        sortByButton.setTitleColor(.label, for: .normal)
        sortByButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        sortByButton.contentHorizontalAlignment = .left
        sortByButton.backgroundColor = .systemBackground
        sortByButton.addTarget(self, action: #selector(sortByVC), for: .touchUpInside)
        self.view.addSubview(sortByButton)
        
        // Label - For: Sort By
        let labelWidth = CGFloat(150)
        
        let sortByStatusLabel = UILabel()
        sortByStatusLabel.frame = CGRect(x: self.view.frame.width - (20 + labelWidth), y: 35, width: labelWidth, height: 50)
        sortByStatusLabel.text = currenetSelectedSortOption?.getSelectedSortByFeedOptionAsString(sortByFeedSelectedOption: self.currenetSelectedSortOption!) // "Newest to oldest"
        sortByStatusLabel.textColor = .secondaryLabel
        sortByStatusLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        self.view.addSubview(sortByStatusLabel)
    }
    
    @objc func sortByVC() {
        performSegue(withIdentifier: "showSortByFeedSubFilterVC", sender: self)
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return true
    }
    
    override func getPopupHeight() -> CGFloat {
        120
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        10
    }
    
    override func getPopupPresentDuration() -> Double {
        0.25
    }
    
    /*
    override func getPopupDismissDuration() -> Double {
        0.25
    }*/
    
}
