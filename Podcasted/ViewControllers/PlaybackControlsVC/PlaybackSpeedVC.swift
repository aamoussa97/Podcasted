//
//  PlaybackSpeedVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 12/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import BottomPopup

class PlaybackSpeedVC: BottomPopupViewController {
    
    var playbackVCTitleLabel = UILabel()
    var playbackStepperValueLabel = UILabel()
    
    var playbackRateStepper = UIStepper()
    
    var buttonResetChanges = UIButton()
    var buttonSaveChanges = UIButton()
    
    var playbackRateActual = Double()
    var playbackRateTruncated = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubViews()
    }
    
    func setupView() {
        self.view.backgroundColor = .systemBackground
    }
    
    func addSubViews() {
        // Reset changes button
        buttonResetChanges = UIButton(frame: CGRect(x: 20, y: 200, width: 80, height: 40))
        buttonResetChanges.layer.cornerRadius = 10
        buttonResetChanges.setTitle("Reset", for: .normal)
        buttonResetChanges.setTitleColor(.systemBackground, for: .normal)
        buttonResetChanges.backgroundColor = .systemRed
        buttonResetChanges.addTarget(self, action: #selector(resetStepperValue), for: .touchUpInside)
        self.view.addSubview(buttonResetChanges)
        
        // Save changes button
        buttonSaveChanges = UIButton(frame: CGRect(x: 120, y: 200, width: self.view.frame.width-140, height: 40))
        buttonSaveChanges.layer.cornerRadius = 10
        buttonSaveChanges.setTitle("Save changes", for: .normal)
        buttonSaveChanges.setTitleColor(.systemBackground, for: .normal)
        buttonSaveChanges.backgroundColor = .label
        buttonSaveChanges.addTarget(self, action: #selector(saveChangesFromStepperValue), for: .touchUpInside)
        self.view.addSubview(buttonSaveChanges)
        
        // Title label
        playbackVCTitleLabel = UILabel(frame: CGRect(x: 20, y: 40, width: self.view.frame.width - 120, height: 30))
        playbackVCTitleLabel.text = "Playback speed"
        playbackVCTitleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        self.view.addSubview(playbackVCTitleLabel)
        
        // Playback stepper value label
        playbackStepperValueLabel = UILabel(frame: CGRect(x: 20, y: 100, width: self.view.frame.width - 120, height: 40))
        playbackStepperValueLabel.text = "\(playbackRateActual)x"
        playbackStepperValueLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        self.view.addSubview(playbackStepperValueLabel)
        
        // Playback rate stepper
        playbackRateStepper = UIStepper(frame:CGRect(x: self.view.frame.width-140, y: 120, width: 0, height: 0))
        playbackRateStepper.autorepeat = true
        playbackRateStepper.value = playbackRateActual
        playbackRateStepper.stepValue = 0.1
        playbackRateStepper.minimumValue = 0.1
        playbackRateStepper.maximumValue = 3
        playbackRateStepper.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        playbackRateStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(playbackRateStepper)
    }
    
    @objc func stepperValueChanged(_ sender:UIStepper!)
    {
        self.playbackRateTruncated = sender.value.truncate(to: 2)
        self.playbackStepperValueLabel.text = "\(playbackRateTruncated)x"
    }
    
    @objc func resetStepperValue() {
        self.playbackRateTruncated = 1.0
        self.playbackRateStepper.value = 1
        self.playbackStepperValueLabel.text = "1x"
        
        saveChangesFromStepperValue()
    }
    
    @objc func saveChangesFromStepperValue() {
        self.performSegue(withIdentifier: "unwindToPlayingNowVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! PlayingNowVC
        destVC.playbackSpeedRate = self.playbackRateTruncated
        destVC.updatePlaybackSpeedRateAVPlayer()
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
