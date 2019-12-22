//
//  SettingsAboutVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 16/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import SwiftyFORM

class SettingsAboutVC: FormViewController {
    
    override func populate(_ builder: FormBuilder) {
        builder.navigationTitle = "About"
        
        builder.demo_showInfo("PodcastedNeo\n Version \(UIApplication.appVersion ?? "Version")")

        builder += SectionHeaderTitleFormItem(title: "Developer")
        builder += StaticTextFormItem().title("Developer").value("Ali Moussa")
        builder += SectionFormItem()
        builder += SectionHeaderTitleFormItem(title: "App specific info")
        builder += StaticTextFormItem().title("Bundle identifier").value(UIApplication.appBundleIdentifier ?? "Version")
        builder += StaticTextFormItem().title("Bundle name").value(UIApplication.appBundleName ?? "Bundle name")
    }
    
}
