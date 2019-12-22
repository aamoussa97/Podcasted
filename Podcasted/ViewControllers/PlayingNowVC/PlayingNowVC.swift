//
//  PlayingNowVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 19/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import MediaPlayer
import CoreData
import SDWebImage
import SwiftIcons

class PlayingNowVC: UIViewController {
    
    @IBOutlet weak var ImageView_PodcastIcon: UIImageView!

    @IBOutlet weak var View_PodcastExtraControls: UIView!
    
    @IBOutlet weak var Label_PodcastEpisodeName: UILabel!
    @IBOutlet weak var Label_PodcastNowTime: UILabel!
    @IBOutlet weak var Label_PodcastEndTime: UILabel!
   
    @IBOutlet weak var Slider_PodcastScrubber: UISlider!
    
    @IBOutlet weak var Button_ShowPlaybackSpeed: UIButton!
    @IBOutlet weak var Button_ShowAboutEpisode: UIButton!
    @IBOutlet weak var Button_ShowQueue: UIButton!
    @IBOutlet weak var Button_PlayPausePodcast: UIButton!
    @IBOutlet weak var Button_SeekBackPodcast: UIButton!
    @IBOutlet weak var Button_SeekForwardPodcast: UIButton!
    @IBOutlet weak var Button_ShowAirPlayPicker: UIButton!
    @IBOutlet weak var Button_ShowSleepTimer: UIButton!
    
    @IBAction func Slider_PodcastScrubberValueChanged(_ sender: Any) {
        seekAVPlayer(timeToSeekFromSlider: self.Slider_PodcastScrubber?.value ?? 0)
    }
    
    @IBAction func Button_ShowPlaybackSpeed(_ sender: Any) {
        showPlaybackSpeedVC()
    }
    
    @IBAction func Button_ShowSleepTimer(_ sender: Any) {
        showPlaybackSleepTimerVC()
    }
    
    @IBAction func Button_ShowAboutEpisode(_ sender: Any) {
        showAboutEpisodeVC()
    }
    
    @IBAction func Button_ShowAirPlayPicker(_ sender: Any) {
        showAirPlayPicker()
    }
    
    @IBAction func Button_ShowQueue(_ sender: Any) {
        showQueueVC()
    }
    
    @IBAction func Button_PlayPausePodcast(_ sender: Any) {
        if self.isAVPlayerAudioPaused == true {
            playAVPlayer()
        } else {
            pauseAVPlayer()
        }
    }
    
    @IBAction func Button_SeekBackPodcast(_ sender: Any) {
        seekBackAVPlayer()
    }
    
    @IBAction func Button_SeekForwardPodcast(_ sender: Any) {
        seekForwardAVPlayer()
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appSharedDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var appTintUIColorFromUserDefaults: UIColor?
    
    var avPlayer = AudioPlayerProvider.sharedProvider.avPlayer
    var avPlayerItem = AudioPlayerProvider.sharedProvider.avPlayerItem
    
    var playbackRateActual = Double()
    var playbackSpeedRate = Double()
    var isAVPlayerAudioPaused = false
    
    var episodeByPodcast: EpisodesByPodcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfEpisodeExistsInQueueInCoreData()
        
        setupAppTintColor()
        setupPlayingNowScreen()
        setupAVPlayer()
    }
    
    func setupAppTintColor() {
        // Set tintColor from UserDefaults
        appTintUIColorFromUserDefaults = appSharedDelegate.loadAppTintUIColorFromUserDefaults()
    }
    
    func checkIfEpisodeExistsInQueueInCoreData() {
        let request: NSFetchRequest<QueueEpisode> = QueueEpisode.fetchRequest()
        let predicate = NSPredicate(format: "episodeID == %@", episodeByPodcast?.episodesByPodcast_EpisodeID ?? "")
        request.predicate = predicate
        request.fetchLimit = 1

        do {
          let count = try context.count(for: request)
          
            debugPrint(count)
            
            if(count == 0) {
                // no matching object
                addPlayedEpisodeToQueueToCoreData()
            }
        
        } catch {
            debugPrint("Error saving context \(error)")
        
        }
    }
    
    func checkIfEpisodeHasTimePlayedInQueueInCoreData(episodeToBePlayed: EpisodesByPodcast) {
        let request: NSFetchRequest<QueueEpisode> = QueueEpisode.fetchRequest()
        let predicate = NSPredicate(format: "episodeID == %@", episodeToBePlayed.episodesByPodcast_EpisodeID ?? "")
        request.predicate = predicate
        request.fetchLimit = 1

        do {
            let requestResult = try context.fetch(request)
          
            for data in requestResult as! [NSManagedObject] {
                var episodeTimePlayed = data.value(forKey: "episodeTimePlayed") as! Int
                var episodeTimeLength = data.value(forKey: "episodeLength") as! Int
                var episodeMarkedAsPlayed = data.value(forKey: "episodeMarkedAsPlayed") as! Bool
                
                if (episodeMarkedAsPlayed == false && episodeTimePlayed < episodeTimeLength) {
                    self.seekAVPlayer(timeToSeek: Double(episodeTimePlayed))
                }
            }
            
        } catch {
            debugPrint("Error saving context \(error)")
        }
    }
    
    func addPlayedEpisodeToQueueToCoreData() {
        let newPlayedEpisodeToQueue = QueueEpisode(context: self.context)
        newPlayedEpisodeToQueue.episodeIconURL = self.episodeByPodcast?.episodesByPodcast_PodcastIconURL
        newPlayedEpisodeToQueue.episodeID = self.episodeByPodcast?.episodesByPodcast_EpisodeID
        newPlayedEpisodeToQueue.episodeURL = self.episodeByPodcast?.episodesByPodcast_EpsiodeURL
        newPlayedEpisodeToQueue.episodeDescription = self.episodeByPodcast?.episodesByPodcast_EpisodeDescription
        newPlayedEpisodeToQueue.episodeName = self.episodeByPodcast?.episodesByPodcast_EpisodeName
        newPlayedEpisodeToQueue.episodeLength = Int64(self.episodeByPodcast?.episodesByPodcast_EpisodeLength ?? 0) //0
        newPlayedEpisodeToQueue.episodeTimePlayed = 0
        newPlayedEpisodeToQueue.episodeMarkedAsPlayed = false
        newPlayedEpisodeToQueue.episodePubDateMS = Int64(self.episodeByPodcast?.episodesByPodcast_PubDateMS ?? 0) // 0
            
        do {
            try context.save()
            
        } catch {
            debugPrint("Error saving context \(error)")
        }
    }
    
    func saveTimePlayedForCurrentEpisode() {
        let currentPlayingEpisode = episodeByPodcast
 
        let currentTimestampInPlayingEpisodeInSec = avPlayer?.currentTime().seconds

        let request: NSFetchRequest<QueueEpisode> = QueueEpisode.fetchRequest()
        let predicate = NSPredicate(format: "episodeID == %@", currentPlayingEpisode?.episodesByPodcast_EpisodeID ?? "")
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            
            let requestResults =
                try context.fetch(request)
            let objectToUpdate = requestResults[0] as NSManagedObject
            objectToUpdate.setValue(currentTimestampInPlayingEpisodeInSec, forKey: "episodeTimePlayed")
            
            do {
                try context.save()
            
            } catch let error as NSError {
              debugPrint("Error saving context \(error)")
            }
            
        } catch {
            debugPrint("Error saving context \(error)")
        }
    }
 
    func setupPlayingNowScreen() {
        self.Label_PodcastEpisodeName.text = self.episodeByPodcast?.episodesByPodcast_EpisodeName ?? "Episode Name"
        self.Label_PodcastEpisodeName.accessibilityLabel = "PlayingNowPodcastEpisodeName"
        
        let podcastIconImageURL = URL(string: self.episodeByPodcast?.episodesByPodcast_PodcastIconURL ?? "")
        self.ImageView_PodcastIcon.sd_setImage(with: podcastIconImageURL)
        self.ImageView_PodcastIcon.accessibilityLabel = "PlayingNowPodcastIcon"
        
        setupPlayingNowScreenButtons()
    }
    
    func setupPlayingNowScreenButtons() {
        self.Button_PlayPausePodcast.setIcon(icon: .fontAwesomeSolid(.play), iconSize: 60, color: .label, forState: .normal)
        self.Button_PlayPausePodcast.accessibilityLabel = "PlayingNowPlayPausePodcast"
        
        self.Button_SeekBackPodcast.setIcon(icon: .fontAwesomeSolid(.undo), iconSize: 40, color: .label, forState: .normal)
        self.Button_SeekBackPodcast.accessibilityLabel = "PlayingNowSeekBackPodcast"
        
        self.Button_SeekForwardPodcast.setIcon(icon: .fontAwesomeSolid(.redo), iconSize: 40, color: .label, forState: .normal)
        self.Button_SeekForwardPodcast.accessibilityLabel = "PlayingNowForwardPodcast"
        
        self.Button_ShowAboutEpisode.setIcon(icon: .fontAwesomeSolid(.alignLeft), iconSize: 20, color: .systemBackground, forState: .normal)
        self.Button_ShowQueue.setIcon(icon: .fontAwesomeSolid(.thList), iconSize: 20, color: .systemBackground, forState: .normal)
        
        self.Button_ShowAirPlayPicker.setIcon(icon: .fontAwesomeSolid(.broadcastTower), iconSize: 20, color: .systemBackground, forState: .normal)
        self.Button_ShowAirPlayPicker.accessibilityLabel = "PlayingNowShowAirPlayPicker"
        
        self.Button_ShowSleepTimer.setIcon(icon: .fontAwesomeSolid(.clock), iconSize: 20, color: .systemBackground, forState: .normal)
        self.Button_ShowSleepTimer.accessibilityLabel = "PlayingNowShowSleepTimer"
        
        self.Button_ShowPlaybackSpeed.setIcon(icon: .fontAwesomeSolid(.tachometerAlt), iconSize: 20, color: .systemBackground, forState: .normal)
        self.Button_ShowPlaybackSpeed.accessibilityLabel = "PlayingNowShowPlaybackSpeed"
        
        self.View_PodcastExtraControls.backgroundColor = .label
        self.View_PodcastExtraControls.layer.cornerRadius = 7
        self.View_PodcastExtraControls.accessibilityLabel = "PlayingNowPodcastExtraControls"
    
        self.Button_ShowAboutEpisode.backgroundColor = .label
        self.Button_ShowAboutEpisode.setTitleColor(.white, for: .normal)
        self.Button_ShowAboutEpisode.layer.cornerRadius = 7
        self.Button_ShowAboutEpisode.accessibilityLabel = "PlayingNowShowAboutEpisode"
        
        self.Button_ShowQueue.backgroundColor = .label
        self.Button_ShowQueue.setTitleColor(.white, for: .normal)
        self.Button_ShowQueue.layer.cornerRadius = 7
        self.Button_ShowQueue.accessibilityLabel = "PlayingNowShowShowQueue"
    }
    
    func setupAVPlayer() {
        var podcast_URL: String? // = episodeByPodcast?.episodesByPodcast_EpsiodeURL ?? "URL"
                
        if episodeByPodcast?.episodesByPodcast_EpisodePathLocal != nil {
            guard var trueDocumentsLocation = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            
            guard let fileURL = URL(string: episodeByPodcast?.episodesByPodcast_EpisodePathLocal ?? "PATH") else { return }
            let fileName = fileURL.lastPathComponent
            
            trueDocumentsLocation.appendPathComponent(fileName)
            
            podcast_URL = trueDocumentsLocation.absoluteString
        } else {
            podcast_URL = URL(string: episodeByPodcast?.episodesByPodcast_EpsiodeURL ?? "URL")!.absoluteString
        }
        
        let url = NSURL(string: podcast_URL ?? "URL")
        print("Did setup URL: \(String(describing: url))")
        
        avPlayerItem = AVPlayerItem.init(url: url! as URL)
        avPlayer = AVPlayer.init(playerItem: avPlayerItem)
        avPlayer?.volume = 1.0
        
        setupAVAudioSession()
        checkIfEpisodeHasTimePlayedInQueueInCoreData(episodeToBePlayed: episodeByPodcast!)
        
        avPlayer?.play()
        self.isAVPlayerAudioPaused = false
        
        NotificationCenter.default.addObserver(
               self,
               selector: #selector(currentAVPlayerDidEnd),
               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
               object: nil)
        
        setupPlayingNowScreenWithTimes()
    }
    
    func setupAVAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [.defaultToSpeaker, .allowAirPlay, .allowBluetooth])
            try audioSession.setActive(true)
        } catch let sessionError {
            debugPrint(sessionError)
        }
        
        setupRemoteTransportControls()
    }
    
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
    
    func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()

        commandCenter.previousTrackCommand.isEnabled = false
        commandCenter.nextTrackCommand.isEnabled = false
        commandCenter.changePlaybackPositionCommand.isEnabled = true
        commandCenter.seekBackwardCommand.isEnabled = true
        commandCenter.seekForwardCommand.isEnabled = true
        
        func skipBackward(_ event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus {
            guard let command = event.command as? MPSkipIntervalCommand else {
                return .noSuchContent
            }

            let interval = command.preferredIntervals[0] // interval: number of seconds to seek
            
            self.seekBackAVPlayer()
            self.updateNowPlayingLockScreenControls()

            return .success
        }

        func skipForward(_ event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus {
            guard let command = event.command as? MPSkipIntervalCommand else {
                return .noSuchContent
            }

            let interval = command.preferredIntervals[0] // interval: number of seconds to seek
            
            self.seekForwardAVPlayer()
            self.updateNowPlayingLockScreenControls()

            return .success
        }
        
        let seekBackwardCommand = commandCenter.skipBackwardCommand
        seekBackwardCommand.isEnabled = true
        seekBackwardCommand.addTarget(handler: skipBackward)
        seekBackwardCommand.preferredIntervals = [NSNumber(value: loadSeekValuesFromUserDefaults().0)]

        let seekForwardCommand = commandCenter.skipForwardCommand
        seekForwardCommand.isEnabled = true
        seekForwardCommand.addTarget(handler: skipForward)
        seekForwardCommand.preferredIntervals = [NSNumber(value: loadSeekValuesFromUserDefaults().1)]
        
        commandCenter.changePlaybackPositionCommand.addTarget { event -> MPRemoteCommandHandlerStatus in
            let event = event as! MPChangePlaybackPositionCommandEvent
            self.seekAVPlayer(timeToSeekFromSlider: Float(event.positionTime / 60))
            return .success
        }
        
        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.avPlayer?.rate == 0.0 {
                self.avPlayer?.play()
                return .success
            }
            return .commandFailed
        }

        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.avPlayer?.rate == 1.0 {
                self.avPlayer?.pause()
                return .success
            }
            return .commandFailed
        }
        
    }
    
    func updateNowPlayingLockScreenControls() {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = episodeByPodcast?.episodesByPodcast_EpisodeName
        nowPlayingInfo[MPMediaItemPropertyArtist] = episodeByPodcast?.episodesByPodcast_PodcastName

        if let image = self.ImageView_PodcastIcon.image {
            nowPlayingInfo[MPMediaItemPropertyArtwork] =
                MPMediaItemArtwork(boundsSize: image.size) { size in
                    return image
            }
        }
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = avPlayerItem?.currentTime().seconds
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = avPlayerItem?.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = avPlayer?.rate
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        MPNowPlayingInfoCenter.default().playbackState = .playing
    }
    
    func setupPlayingNowScreenWithTimes() {
        let podcastNowTimeInMin = CMTimeGetSeconds(avPlayer?.currentItem?.currentTime() ?? CMTime(seconds: 0, preferredTimescale: 0)) / 60
        self.Label_PodcastNowTime.text = String(podcastNowTimeInMin.truncate(to: 2))
        
        let podcastEndTimeInMin = CMTimeGetSeconds(avPlayer?.currentItem?.asset.duration ?? CMTime(seconds: 0, preferredTimescale: 0)) / 60
        self.Label_PodcastEndTime.text = String(podcastNowTimeInMin.truncate(to: 2))
   
        self.Slider_PodcastScrubber.minimumValue = Float(0)
        self.Slider_PodcastScrubber.maximumValue = Float(podcastEndTimeInMin)
        
        setupPlayingNowScreenSlider()
        
        updateNowPlayingLockScreenControls()
        updatePlayingNowScreen()
    }
    
    func setupPlayingNowScreenSlider() {
        self.Slider_PodcastScrubber.minimumTrackTintColor = .systemGray
        self.Slider_PodcastScrubber.maximumTrackTintColor = .systemGray5
        self.Slider_PodcastScrubber.isContinuous = false
    }
    
    func updatePlayingNowScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            
            if self.isAVPlayerAudioPaused == true {
                self.Button_PlayPausePodcast.setIcon(icon: .fontAwesomeSolid(.play), iconSize: 60, color: .label, forState: .normal)
            } else {
                self.Button_PlayPausePodcast.setIcon(icon: .fontAwesomeSolid(.pause), iconSize: 60, color: .label, forState: .normal)
            }
            
            let podcastNowTimeInSec = CMTimeGetSeconds(self.avPlayer?.currentItem?.currentTime() ?? CMTime(seconds: 0, preferredTimescale: 0)) / 60
            self.Label_PodcastNowTime.text = String(podcastNowTimeInSec.truncate(to: 2))
            
            let podcastEndTimeInSec = CMTimeGetSeconds(self.avPlayer?.currentItem?.asset.duration ?? CMTime(seconds: 0, preferredTimescale: 0)) / 60
            let calculatedRemainingEndTime = podcastEndTimeInSec - podcastNowTimeInSec
            self.Label_PodcastEndTime.text = String("-\(calculatedRemainingEndTime.truncate(to: 2))")
            
            self.Slider_PodcastScrubber.value = Float(podcastNowTimeInSec)
            
            self.updatePlayingNowScreen()
        }
    }
    
    func showPlaybackSleepTimerOptionMenu() {
        let optionMenu = UIAlertController(title: nil, message: "Sleep Timer", preferredStyle: .actionSheet)
        optionMenu.view.tintColor = appTintUIColorFromUserDefaults
        
        let sleepAfter5Minutes = UIAlertAction(title: "5 minutes", style: .default) { (UIAlertAction) in
            self.sleepTimerStopAVPlayer(timeIntervalToSleep: 5)
        }
        
        let sleepAfter15Minutes = UIAlertAction(title: "15 minutes", style: .default) { (UIAlertAction) in
            self.sleepTimerStopAVPlayer(timeIntervalToSleep: 15)
        }
        
        let sleepAfter30Minutes = UIAlertAction(title: "30 minutes", style: .default) { (UIAlertAction) in
            self.sleepTimerStopAVPlayer(timeIntervalToSleep: 30)
        }
        
        let sleepAfter1Hour = UIAlertAction(title: "1 hour", style: .default) { (UIAlertAction) in
            self.sleepTimerStopAVPlayer(timeIntervalToSleep: 60)
        }
        
        let sleepAfterEpisodeEnd = UIAlertAction(title: "End of episode", style: .default) { (UIAlertAction) in
            let episodeCurrentTime = CMTimeGetSeconds(self.avPlayer?.currentItem?.currentTime() ?? CMTime(seconds: 0, preferredTimescale: 0))
            let episodeEndTime = CMTimeGetSeconds(self.avPlayer?.currentItem?.asset.duration ?? CMTime(seconds: 0, preferredTimescale: 0))
            let remainingEpisodeTime = episodeEndTime - episodeCurrentTime
            self.sleepTimerStopAVPlayer(timeIntervalToSleep: remainingEpisodeTime)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
        optionMenu.addAction(sleepAfter5Minutes)
        optionMenu.addAction(sleepAfter15Minutes)
        optionMenu.addAction(sleepAfter30Minutes)
        optionMenu.addAction(sleepAfter1Hour)
        optionMenu.addAction(sleepAfterEpisodeEnd)
        optionMenu.addAction(cancelAction)
            
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func sleepTimerStopAVPlayer(timeIntervalToSleep: Double) {
        let timeIntervalToSleepSeconds = timeIntervalToSleep * 60
        
        var sleepTimer = Timer()
        sleepTimer.invalidate()
        sleepTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timeIntervalToSleepSeconds), target: self, selector: #selector(pauseAVPlayer), userInfo: nil, repeats: false)
    }
        
    func showPlaybackSpeedVC() {
        performSegue(withIdentifier: "showPlaybackSpeedVC", sender: self)
    }
    
    func updatePlaybackSpeedRateAVPlayer() {
        avPlayer?.playImmediately(atRate: Float(self.playbackSpeedRate))
    }
        
    func showPlaybackSleepTimerVC() {
        showPlaybackSleepTimerOptionMenu()
    }
    
    func showAboutEpisodeVC() {
        performSegue(withIdentifier: "showAboutEpisodeVC", sender: self)
    }
    
    func showQueueVC() {
        performSegue(withIdentifier: "showQueueVC", sender: self)
    }
    
    func playAVPlayer() {
        avPlayer?.play()
        self.isAVPlayerAudioPaused = false
    }
    
    @objc func pauseAVPlayer() {
        avPlayer?.pause()
        self.isAVPlayerAudioPaused = true
        
        saveTimePlayedForCurrentEpisode()
    }
    
    func seekAVPlayer(timeToSeekFromSlider: Float) {
        var timeToSeekFromSliderInSec = Double(timeToSeekFromSlider * 60)
        
        avPlayer?.seek(to: CMTime(seconds: timeToSeekFromSliderInSec, preferredTimescale: 1))
    }
    
    func seekAVPlayer(timeToSeek: Double) {
        avPlayer?.seek(to: CMTime(seconds: timeToSeek, preferredTimescale: 1))
    }
    
    func seekBackAVPlayer() {
        var timeNowFromPlayer = avPlayer?.currentTime().seconds ?? 0.0
        
        var timeToSeekFromInput = -loadSeekValuesFromUserDefaults().0
        var timeToSeekInSecondsPlusPlayer: Double = Double(timeToSeekFromInput) + Double(timeNowFromPlayer)
        
        var timeToSeekInMinutes = timeToSeekInSecondsPlusPlayer * 60/60
        
        avPlayer?.seek(to: CMTimeMake(value: Int64(timeToSeekInMinutes), timescale: 1))
    }
    
    func seekForwardAVPlayer() {
        var timeNowFromPlayer = avPlayer?.currentTime().seconds ?? 0.0
        
        var timeToSeekFromInput = loadSeekValuesFromUserDefaults().1
        var timeToSeekInSecondsPlusPlayer: Double = Double(timeToSeekFromInput) + Double(timeNowFromPlayer)
        
        var timeToSeekInMinutes = timeToSeekInSecondsPlusPlayer * 60/60
        
        avPlayer?.seek(to: CMTimeMake(value: Int64(timeToSeekInMinutes), timescale: 1))
    }
    
    @objc func currentAVPlayerDidEnd() {
        let currentPlayingEpisodeFromPlayingNow = episodeByPodcast
        
        // Remove current item from Queue Core Data
        removeEpisodeFromQueueInCoreData(episodeToDeleteFromPlayingNow: currentPlayingEpisodeFromPlayingNow!)
        
        // Add current item to FinishedEpisode Core Data
        addEpisodeToFinishedInCoreData(episodeToMarkAsFinishedFromPlayingNow: currentPlayingEpisodeFromPlayingNow!)
        
        // Play next episode from Queue Core Data
        playNextEpisodeFromQueueInCoreData()
        
        // Reload PlayingNowVC view with new episode from Queue
        //self.view.layoutIfNeeded()
        //self.view.setNeedsLayout()
        //self.view.setNeedsDisplay()
    }
    
    func removeEpisodeFromQueueInCoreData(episodeToDeleteFromPlayingNow: EpisodesByPodcast) {
        let request: NSFetchRequest<QueueEpisode> = QueueEpisode.fetchRequest()
        request.predicate = NSPredicate(format: "episodeID == %@", episodeToDeleteFromPlayingNow.episodesByPodcast_EpisodeID ?? "")
        request.fetchLimit = 1
        
        do {
            let result = try context.fetch(request)
            
            for object in result {
                context.delete(object)
            }
            
            try context.save()
            
        } catch {
            debugPrint("Error saving context \(error)")
        
        }
    }
    
    func addEpisodeToFinishedInCoreData(episodeToMarkAsFinishedFromPlayingNow: EpisodesByPodcast) {
        let entity = NSEntityDescription.entity(forEntityName: "FinishedEpisode", in: self.context)!
        let newFinishedEpisodeToFinished = NSManagedObject(entity: entity, insertInto: self.context)
        
        newFinishedEpisodeToFinished.setValue(episodeToMarkAsFinishedFromPlayingNow.episodesByPodcast_PodcastIconURL, forKey: "episodeIconURL")
        newFinishedEpisodeToFinished.setValue(episodeToMarkAsFinishedFromPlayingNow.episodesByPodcast_EpisodeID, forKey: "episodeID")
        newFinishedEpisodeToFinished.setValue(episodeToMarkAsFinishedFromPlayingNow.episodesByPodcast_EpsiodeURL, forKey: "episodeURL")
        newFinishedEpisodeToFinished.setValue(episodeToMarkAsFinishedFromPlayingNow.episodesByPodcast_EpisodeDescription, forKey: "episodeDescription")
        newFinishedEpisodeToFinished.setValue(episodeToMarkAsFinishedFromPlayingNow.episodesByPodcast_EpisodeName, forKey: "episodeName")
        newFinishedEpisodeToFinished.setValue(Int64(episodeToMarkAsFinishedFromPlayingNow.episodesByPodcast_EpisodeLength ?? 0), forKey: "episodeLength")
        newFinishedEpisodeToFinished.setValue(0, forKey: "episodeTimePlayed")
        newFinishedEpisodeToFinished.setValue(true, forKey: "episodeMarkedAsPlayed")
        newFinishedEpisodeToFinished.setValue(Int64(episodeToMarkAsFinishedFromPlayingNow.episodesByPodcast_PubDateMS ?? 0), forKey: "episodePubDateMS")
    
        do {
            try context.save()
            
        } catch {
            debugPrint("Error saving context \(error)")
        }
    }
    
    func playNextEpisodeFromQueueInCoreData() {
        let request: NSFetchRequest<QueueEpisode> = QueueEpisode.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "episodeOrderPosition", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        request.fetchLimit = 1
        
        do {
            let result = try context.fetch(request)
            
            debugPrint(result.first!.episodeOrderPosition)
            
            self.episodeByPodcast?.episodesByPodcast_EpisodeID = result.first!.episodeID
            self.episodeByPodcast?.episodesByPodcast_EpisodeDescription = result.first!.episodeDescription
            self.episodeByPodcast?.episodesByPodcast_PodcastIconURL = result.first!.episodeIconURL
            self.episodeByPodcast?.episodesByPodcast_EpisodeLength = Int(result.first!.episodeLength ?? 0)
            self.episodeByPodcast?.episodesByPodcast_EpisodeName = result.first!.episodeName
            self.episodeByPodcast?.episodesByPodcast_PubDateMS = Int(result.first!.episodePubDateMS ?? 0)
            self.episodeByPodcast?.episodesByPodcast_EpsiodeURL = result.first!.episodeURL
        
            try context.save()
            
        } catch {
            debugPrint("Error saving context \(error)")
        
        }
    }

    func showAirPlayPicker() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        //let AirPlayPickerView = AVRoutePickerView(frame: CGRect(x: screenSize.width/2, y: screenSize.height-100, width: 50, height: 50))
        let AirPlayPickerView = AVRoutePickerView(frame: CGRect(x: self.Button_ShowAirPlayPicker.frame.origin.x, y: self.Button_ShowAirPlayPicker.frame.origin.y, width: 50, height: 50))
        AirPlayPickerView.prioritizesVideoDevices = false
        
        debugPrint(screenSize.width/2)
        debugPrint(screenSize.height-100)
        
        //self.Button_ShowAirPlayPicker.frame.origin.x
        //self.Button_ShowAirPlayPicker.frame.origin.y
        //AirPlayPickerView.activeTintColor = .systemPurple
        
        self.view.addSubview(AirPlayPickerView)
    }
    
    @IBAction func unwindToPlayingNowVC(_ sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavVC = segue.destination as? UINavigationController, let destinationVC = destinationNavVC.topViewController as? AboutEpisodeVC {
            destinationVC.episodeByPodcast = episodeByPodcast
        }
        
        if let playbackSpeedVC = segue.destination as? PlaybackSpeedVC {
            playbackRateActual = Double(avPlayer?.rate ?? 1).truncate(to: 2)
            playbackSpeedVC.playbackRateActual = playbackRateActual
        }
        
        if let destinationQueueNavVC = segue.destination as? UINavigationController, let destinationVC = destinationQueueNavVC.topViewController as? QueueVC {
            destinationVC.currentPlayingEpisodeByPodcast = episodeByPodcast
        }
    }
}
