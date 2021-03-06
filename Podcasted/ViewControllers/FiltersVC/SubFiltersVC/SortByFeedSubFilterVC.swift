//
//  SortByFeedSubFilterVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 15/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import BottomPopup

class SortByFeedSubFilterVC: BottomPopupViewController {
    
    let appSharedDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var selectedSortByOption: SortByFeed?
    
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
        
        // Label - For: Title
        let vcTitleLabel = UILabel()
        vcTitleLabel.frame = CGRect(x: 20, y: 1.5, width: 200, height: 50)
        vcTitleLabel.text = "SORT BY"
        vcTitleLabel.textColor = appTintUIColorFromUserDefaults
        vcTitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        vcTitleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.view.addSubview(vcTitleLabel)
    
        // Button - For: Sort By Podcast Name
        let sortByPodcastNameButton = UIButton(frame: CGRect(x: 20, y: 45, width: self.view.frame.width-20, height: 50))
        //sortByPodcastNameButton.layer.cornerRadius = 10
        sortByPodcastNameButton.setTitle("Podcast Name", for: .normal)
        sortByPodcastNameButton.setTitleColor(.label, for: .normal)
        sortByPodcastNameButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        sortByPodcastNameButton.contentHorizontalAlignment = .left
        sortByPodcastNameButton.backgroundColor = .systemBackground
        sortByPodcastNameButton.addTarget(self, action: #selector(sortByPodcastName), for: .touchUpInside)
        self.view.addSubview(sortByPodcastNameButton)
        
        // Divider line
        var dividerLineOne = UIView(frame: CGRect(x: 20, y: 105, width: self.view.frame.width - 20, height: 1.0))
        dividerLineOne.layer.borderWidth = 1.0
        dividerLineOne.layer.opacity = 0.25
        dividerLineOne.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(dividerLineOne)
        
        // Button - For: Sort By Episode Name
        let sortByEpisodeNameButton = UIButton(frame: CGRect(x: 20, y: 110, width: self.view.frame.width-20, height: 50))
        //sortByEpisodeNameButton.layer.cornerRadius = 10
        sortByEpisodeNameButton.setTitle("Episode Name", for: .normal)
        sortByEpisodeNameButton.setTitleColor(.label, for: .normal)
        sortByEpisodeNameButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        sortByEpisodeNameButton.contentHorizontalAlignment = .left
        sortByEpisodeNameButton.backgroundColor = .systemBackground
        sortByEpisodeNameButton.addTarget(self, action: #selector(sortByEpisodeName), for: .touchUpInside)
        self.view.addSubview(sortByEpisodeNameButton)
        
        // Divider line
        var dividerLineTwo = UIView(frame: CGRect(x: 20, y: 170, width: self.view.frame.width - 20, height: 1.0))
        dividerLineTwo.layer.borderWidth = 1.0
        dividerLineTwo.layer.opacity = 0.25
        dividerLineTwo.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(dividerLineTwo)
        
        // Button - For: Sort By Episode Release Date
        let sortByNewestToOldestButton = UIButton(frame: CGRect(x: 20, y: 180, width: self.view.frame.width-20, height: 50))
        //sortByEpisodeRelaseDateButton.layer.cornerRadius = 10
        sortByNewestToOldestButton.setTitle("Newest to oldest", for: .normal)
        sortByNewestToOldestButton.setTitleColor(.label, for: .normal)
        sortByNewestToOldestButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        sortByNewestToOldestButton.contentHorizontalAlignment = .left
        sortByNewestToOldestButton.backgroundColor = .systemBackground
        sortByNewestToOldestButton.addTarget(self, action: #selector(sortByNewestToOldest), for: .touchUpInside)
        self.view.addSubview(sortByNewestToOldestButton)
        
        // Divider line
        var dividerLineThree = UIView(frame: CGRect(x: 20, y: 240, width: self.view.frame.width - 20, height: 1.0))
        dividerLineThree.layer.borderWidth = 1.0
        dividerLineThree.layer.opacity = 0.25
        dividerLineThree.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(dividerLineThree)
        
        // Button - For: Sort By Episode Release Date
        let sortByOldestToNewestButton = UIButton(frame: CGRect(x: 20, y: 245, width: self.view.frame.width-20, height: 50))
        //sortByEpisodeRelaseDateButton.layer.cornerRadius = 10
        sortByOldestToNewestButton.setTitle("Oldest to newest", for: .normal)
        sortByOldestToNewestButton.setTitleColor(.label, for: .normal)
        sortByOldestToNewestButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        sortByOldestToNewestButton.contentHorizontalAlignment = .left
        sortByOldestToNewestButton.backgroundColor = .systemBackground
        sortByOldestToNewestButton.addTarget(self, action: #selector(sortByOldestToNewest), for: .touchUpInside)
        self.view.addSubview(sortByOldestToNewestButton)
    }
    
    @objc func sortByPodcastName() {
        self.selectedSortByOption = .SortByPodcastName
        
        self.performSegue(withIdentifier: "unwindToFeedVC", sender: self)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func sortByEpisodeName() {
        self.selectedSortByOption = .SortByEpisodeName
        
        self.performSegue(withIdentifier: "unwindToFeedVC", sender: self)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func sortByNewestToOldest() {
        self.selectedSortByOption = .SortByNewestToOldest
        
        self.performSegue(withIdentifier: "unwindToFeedVC", sender: self)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func sortByOldestToNewest() {
        self.selectedSortByOption = .SortByOldestToNewest
        
        self.performSegue(withIdentifier: "unwindToFeedVC", sender: self)

        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! FeedVC

        destVC.sortFeedArrayViaSortByOption(selectedSortByOption: self.selectedSortByOption ?? SortByFeed.SortByNewestToOldest)
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return true
    }
    
    override func getPopupHeight() -> CGFloat {
        325
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        10
    }
    
    override func getPopupPresentDuration() -> Double {
        0.25
    }
    
}
