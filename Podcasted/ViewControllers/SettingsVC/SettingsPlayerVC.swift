//
//  SettingsPlayerVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 16/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import SwiftyFORM

class SettingsPlayerVC: FormViewController {
    
    override func populate(_ builder: FormBuilder) {
        builder.navigationTitle = "Player"
        builder += SectionHeaderTitleFormItem().title("Seeking")
        builder += playerSeekBackwards
        builder += playerSeekFowards
        builder += submitButton
        builder += SectionFormItem()
        builder += resetButton
    }
    
    lazy var playerSeekBackwards: StepperFormItem = {
        let instance = StepperFormItem()
        instance.setValue(loadSeekValuesFromUserDefaults().0, animated: true)
        instance.title = "Seek Backward"
        return instance
    }()
    
    lazy var playerSeekFowards: StepperFormItem = {
        let instance = StepperFormItem()
        instance.setValue(loadSeekValuesFromUserDefaults().1, animated: true)
        instance.title = "Seek Forward"
        return instance
    }()
    
    lazy var submitButton: ButtonFormItem = {
    let instance = ButtonFormItem()
        instance.title = "Save settings"
        instance.action = { [weak self] in
            let playerSeekBackwardsValueFromStepper = self?.playerSeekBackwards.value ?? 0
            let playerSeekForwardsValueFromStepper = self?.playerSeekFowards.value ?? 0
            self?.form_simpleAlert("Update successfull", "New player settings have been saved.")
            
            self?.saveSeekValuesToUserDefaults(seekBackwardValueFromStepper: playerSeekBackwardsValueFromStepper, seekForwardValueFromStepper: playerSeekForwardsValueFromStepper)
        }
        return instance
    }()
    
    lazy var resetButton: ButtonFormItem = {
    let instance = ButtonFormItem()
        instance.title = "Reset settings"
        instance.action = { [weak self] in
            let playerSeekBackwardsResetDefault = 15
            let playerSeekForwardsResetDefault = 15
            
            self?.saveSeekValuesToUserDefaults(seekBackwardValueFromStepper: playerSeekBackwardsResetDefault, seekForwardValueFromStepper: playerSeekForwardsResetDefault)

            self?.playerSeekBackwards.setValue(15, animated: true)
            self?.playerSeekFowards.setValue(15, animated: true)
            
            self?.form_simpleAlert("Reset successfull", "Player settings have been reset to default settings.")
        }
        return instance
    }()
    
    func loadSeekValuesFromUserDefaults() -> (Int, Int) {
        let seekBackwardForwardUserDefaults = UserDefaults.standard
        let seekBackwardFromUserDefaults = seekBackwardForwardUserDefaults.integer(forKey: "settings_player_seekingBackward_value")
        let seekForwardFromUserDefaults = seekBackwardForwardUserDefaults.integer(forKey: "settings_player_seekingForward_value")
    
        if (seekBackwardFromUserDefaults != 0 && seekForwardFromUserDefaults != 0) {
            return (seekBackwardFromUserDefaults, seekForwardFromUserDefaults)
        } else {
            return (15, 15)
        }
    }
    
    func saveSeekValuesToUserDefaults(seekBackwardValueFromStepper: Int, seekForwardValueFromStepper: Int) {
        let seekBackwardForwardUserDefaults = UserDefaults.standard
        
        seekBackwardForwardUserDefaults.set(seekBackwardValueFromStepper, forKey: "settings_player_seekingBackward_value")
        seekBackwardForwardUserDefaults.set(seekForwardValueFromStepper, forKey: "settings_player_seekingForward_value")
    }
    
}
