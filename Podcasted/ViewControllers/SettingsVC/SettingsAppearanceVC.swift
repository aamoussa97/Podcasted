//
//  SettingsAppearanceVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 16/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import SwiftyFORM

class SettingsAppearanceVC: FormViewController {
    override func populate(_ builder: FormBuilder) {
        builder.navigationTitle = "Appearance"
        builder += SectionHeaderTitleFormItem().title("Theme")
        builder += SectionFormItem()
        
        builder += SectionHeaderTitleFormItem().title("App tint")
        builder += slider0
        builder += slider1
        builder += slider2
        builder += colorSummary
        builder += SectionFormItem()
        
        builder += SectionHeaderTitleFormItem().title("App icon")
    
        builder += SectionFormItem()
        builder += SectionHeaderTitleFormItem().title("Podcast artwork")
        builder += useEmbeddedArtworkSwitch
        builder += SectionFooterTitleFormItem().title("Shows embedded artwork in Playing Now and Feed instead of the shows' artwork.")
        
        builder += SectionFormItem()
        builder += submitButton
        
        builder += SectionFormItem()
        builder += resetButton
        
        updateColorSummary()
        updateColorPreview()
    }
    
    lazy var slider0: PrecisionSliderFormItem = {
        let instance = PrecisionSliderFormItem().decimalPlaces(3).minimumValue(0).maximumValue(1000).value(500)
        instance.title = "Red"
        instance.sliderDidChangeBlock = { [weak self] _ in
            self?.updateColorSummary()
            self?.updateColorPreview()
        }
        return instance
    }()

    lazy var slider1: PrecisionSliderFormItem = {
        let instance = PrecisionSliderFormItem().decimalPlaces(3).minimumValue(0).maximumValue(1000).value(500)
        instance.title = "Green"
        instance.sliderDidChangeBlock = { [weak self] _ in
            self?.updateColorSummary()
            self?.updateColorPreview()
        }
        return instance
    }()

    lazy var slider2: PrecisionSliderFormItem = {
        let instance = PrecisionSliderFormItem().decimalPlaces(3).minimumValue(0).maximumValue(1000).value(500)
        instance.title = "Blue"
        instance.sliderDidChangeBlock = { [weak self] _ in
            self?.updateColorSummary()
            self?.updateColorPreview()
        }
        return instance
    }()
        
    lazy var colorPreview: StaticTextFormItem = {
        return StaticTextFormItem().title("Values").value("-")
    }()
    
    lazy var colorSummary: StaticTextFormItem = {
        return StaticTextFormItem().title("Values").value("-")
    }()
    
    func updateColorSummary() {
        let s0 = String(format: "%.3f", slider0.actualValue)
        let s1 = String(format: "%.3f", slider1.actualValue)
        let s2 = String(format: "%.3f", slider2.actualValue)
        colorSummary.value = "\(s0) , \(s1) , \(s2)"
    }

    func updateColorPreview() {
        let color = UIColor(
            red: CGFloat(slider0.actualValue),
            green: CGFloat(slider1.actualValue),
            blue: CGFloat(slider2.actualValue),
            alpha: 1.0
        )
        view?.backgroundColor = color

        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.isTranslucent = false
    }
    
    lazy var useEmbeddedArtworkSwitch: SwitchFormItem = {
    let instance = SwitchFormItem()
    instance.title = "Use Embedded Artwork"
    instance.value = false
    return instance
    }()
    
    lazy var submitButton: ButtonFormItem = {
    let instance = ButtonFormItem()
        instance.title = "Save settings"
        instance.action = { [weak self] in
            self?.form_simpleAlert("Update successfull", "New appearance settings have been saved. Please restart the application for changes to take effect.")
            self?.saveAppTintColorValuesToUserDefaults()
        }
        return instance

    }()
    
    lazy var resetButton: ButtonFormItem = {
    let instance = ButtonFormItem()
        instance.title = "Reset settings"
        instance.action = { [weak self] in
            self?.form_simpleAlert("Reset successfull", "Appearance settings have been reset to default settings. Please restart the application for changes to take effect.")
            self?.resetAppTintColorValuesToUserDefaults()
        }
        return instance

    }()
    
    func resetAppTintColorValuesToUserDefaults() {
        let appTintColorUserDefaults = UserDefaults.standard
        
        let defaultAppTintColor = UIColor.systemBlue
        
        appTintColorUserDefaults.setColor(color: defaultAppTintColor, forKey: "settings_appearance_appTintColor")
    }
    
    func saveAppTintColorValuesToUserDefaults() {
        let appTintColorUserDefaults = UserDefaults.standard
        
        let appTintColor = UIColor(
            red: CGFloat(self.slider0.actualValue),
            green: CGFloat(self.slider1.actualValue),
            blue: CGFloat(self.slider2.actualValue),
            alpha: 1.0
        )
        
        appTintColorUserDefaults.setColor(color: appTintColor, forKey: "settings_appearance_appTintColor")
    }
}
