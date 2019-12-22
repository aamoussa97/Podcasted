//
//  SavedPodcastsFilterVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 14/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import BottomPopup
import TinyConstraints

class SavedPodcastsFilterVC: BottomPopupViewController {
    
    let appSharedDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var currenetSelectedSortOption: SortBySavedPodcasts?
    
    var savedPodcastsLayout: SavedPodcastsLayout?
    
    let filterViewTypes = ["Grid", "Compact", "List"]
    
    lazy var filterViewTypesSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: filterViewTypes)
        control.selectedSegmentIndex = 1
        control.layer.cornerRadius = 10
        control.addTarget(self, action: #selector(handleSegmentedControlValueChanged(_:)), for: .valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubViews()
    }
    
    func setupView() {
        self.view.backgroundColor = .systemBackground
    }
    
    @objc func handleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            savedPodcastsLayout = .Grid
            performSegue(withIdentifier: "showSavedPodcastsGridVC", sender: self)
        case 1:
            savedPodcastsLayout = .Compact
            performSegue(withIdentifier: "showSavedPodcastsGridVC", sender: self)
        case 2:
            savedPodcastsLayout = .List
            performSegue(withIdentifier: "showSavedPodcastsGridVC", sender: self)
        default:
            savedPodcastsLayout = .Grid
            performSegue(withIdentifier: "showSavedPodcastsGridVC", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? SavedPodcastsGridVC {
            destinationVC.savedPodcastsLayout = savedPodcastsLayout
        }
    }
    
    // https://stackoverflow.com/a/50889664
    func image(with image: UIImage?, scaledTo newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(newSize)
        image?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func addSubViews() {
        // Set tintColor from UserDefaults
        let appTintUIColorFromUserDefaults = appSharedDelegate.loadAppTintUIColorFromUserDefaults()
        
        // Constraints
        let rightConstraint = CGFloat(20)
        let leftConstraint = CGFloat(rightConstraint * 3)
        
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
        let labelWidth = CGFloat(130)
        
        let sortByStatusLabel = UILabel()
        sortByStatusLabel.frame = CGRect(x: self.view.frame.width - (20 + labelWidth), y: 35, width: labelWidth, height: 50)
        sortByStatusLabel.text = currenetSelectedSortOption?.getSelectedSortBySavedPodcastsOptionAsString(sortBySavedPodcastsSelectedOption: self.currenetSelectedSortOption!) // "Date added"
        sortByStatusLabel.textColor = .secondaryLabel
        sortByStatusLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        self.view.addSubview(sortByStatusLabel)
        
        // ImageView - For: Layout view
        let layoutViewIcon = UIImageView(image: UIImage(systemName: "square.grid.2x2.fill"))
        layoutViewIcon.frame = CGRect(x: 20, y: 115, width: 25, height: 20)
        layoutViewIcon.tintColor = appTintUIColorFromUserDefaults
        self.view.addSubview(layoutViewIcon)
        
        // Label - For: Layout view
        let layoutViewLabel = UILabel()
        layoutViewLabel.frame = CGRect(x: 60, y: 100, width: 150, height: 50)
        layoutViewLabel.text = "Layout view"
        layoutViewLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        self.view.addSubview(layoutViewLabel)
        
        // Layout view - Segmented Control
        self.view.addSubview(filterViewTypesSegmentedControl)
        filterViewTypesSegmentedControl.frame = CGRect(x: 20, y: 100, width: self.view.frame.width - 120, height: 40)
        filterViewTypesSegmentedControl.edges(to: self.view, excluding: .bottom, insets: UIEdgeInsets(top: 100, left: self.view.frame.width - leftConstraint, bottom: 0, right: rightConstraint), relation: .equal, priority: .defaultLow, isActive: true)
        filterViewTypesSegmentedControl.height(60)
        filterViewTypesSegmentedControl.width(180)
        
        let newImage1 = image(with: (UIImage(systemName: "square.grid.2x2.fill")), scaledTo: CGSize(width: 25, height: 20))
        filterViewTypesSegmentedControl.setImage(newImage1 , forSegmentAt: 0)
        
        let newImage2 = image(with: (UIImage(systemName: "rectangle.grid.3x2.fill")), scaledTo: CGSize(width: 25, height: 20))
        filterViewTypesSegmentedControl.setImage(newImage2 , forSegmentAt: 1)
        
        let newImage3 = image(with: (UIImage(systemName: "list.dash")), scaledTo: CGSize(width: 25, height: 20))
        filterViewTypesSegmentedControl.setImage(newImage3 , forSegmentAt: 2)
    }
    
    @objc func sortByVC() {
        performSegue(withIdentifier: "showSortBySavedSubFilterVC", sender: self)
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return true
    }
    
    override func getPopupHeight() -> CGFloat {
        200
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        10
    }
    
    override func getPopupPresentDuration() -> Double {
        0.25
    }
    
}
