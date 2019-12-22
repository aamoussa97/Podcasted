//
//  SearchPodcastsFilterVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 14/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import BottomPopup

class SearchPodcastsFilterVC: BottomPopupViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubViews()
    }
    
    func setupView() {
        self.view.backgroundColor = .systemBackground
    }
    
    func addSubViews() {
        
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return true
    }
    
    override func getPopupHeight() -> CGFloat {
        300
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        10
    }
    
    override func getPopupPresentDuration() -> Double {
        0.25
    }
    
}
