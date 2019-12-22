//
//  SettingsVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 16/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import SwiftyFORM

class SettingsVC: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupNavBar()
    }
    
    override func populate(_ builder: FormBuilder) {
        builder.navigationTitle = "Settings"
        builder.suppressHeaderForFirstSection = true

        builder += ViewControllerFormItem().title("Player").viewController(SettingsPlayerVC.self)
        builder += ViewControllerFormItem().title("Appearance").viewController(SettingsAppearanceVC.self)
        builder += ViewControllerFormItem().title("About").viewController(SettingsAboutVC.self)
    }
    
    func setupNavBar() {
        let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(showSettings))
        let addToQueueBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), style: .plain, target: self, action: #selector(showSettings))
        let playBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "play.fill"), style: .plain, target: self, action: #selector(showSettings))
                
        //self.navigationItem.rightBarButtonItems = [playBarButtonItem, addToQueueBarButtonItem]
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    @objc func showSettings() {
        //
    }
}

