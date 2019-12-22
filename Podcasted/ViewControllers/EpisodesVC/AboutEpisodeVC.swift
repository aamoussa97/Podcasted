//
//  AboutEpisodeVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 28/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SPAlert
import AFDateHelper

class AboutEpisodeVC: UIViewController {
    
    @IBOutlet weak var Label_PodcastEpisodeName: UILabel!
    @IBOutlet weak var Label_PodcastName: UILabel!
    @IBOutlet weak var TextView_PodcastDescription: UITextView!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var episodeByPodcast: EpisodesByPodcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupAboutEpisodeView()
    }
    
    func setupNavBar() {
        let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(closeAboutScreen))
        let addToDownloadsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(addEpisodeToQueue))
        let addToQueueBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), style: .plain, target: self, action: #selector(addEpisodeToQueue))
        let playBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "play.fill"), style: .plain, target: self, action: #selector(playEpisode))
                
        self.navigationItem.rightBarButtonItems = [playBarButtonItem, addToQueueBarButtonItem, addToDownloadsBarButtonItem]
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupAboutEpisodeView() {
        let pubDateInMS: Int = episodeByPodcast?.episodesByPodcast_PubDateMS ?? 0
        let pubDateInString = pubDateInMS.formatMSToDate(miliseconds: pubDateInMS)
        let pubDateInStringToDate = Date(fromString: pubDateInString, format: .custom("dd-MM-yyyy"))
        let pubDateInStringRelative = pubDateInStringToDate?.toStringWithRelativeTime() ?? ""
        
        let podcastLengthInMinutes = Int(episodeByPodcast?.episodesByPodcast_EpisodeLength ?? 0) / 60
        var podcastRemainingTimeOfEpiosdeInMinutes = calculateRemainingTimeOfEpisode(currentEpisodeInEpisodes: episodeByPodcast!)
        podcastRemainingTimeOfEpiosdeInMinutes = Int(podcastRemainingTimeOfEpiosdeInMinutes) / 60
        let timeRemainingOfEpisodeOrPodcastLength = podcastLengthInMinutes - (podcastRemainingTimeOfEpiosdeInMinutes)
        
        self.Label_PodcastName.text = "\(episodeByPodcast?.episodesByPodcast_PodcastName ?? ""). \(timeRemainingOfEpisodeOrPodcastLength)m . \(pubDateInStringRelative)"
        self.Label_PodcastEpisodeName.text = episodeByPodcast?.episodesByPodcast_EpisodeName
        
        let aboutEpisodeEscaped = episodeByPodcast?.episodesByPodcast_EpisodeDescription.replacingHTMLEntities
        self.TextView_PodcastDescription.text = aboutEpisodeEscaped
    }
    
    func calculateRemainingTimeOfEpisode(currentEpisodeInEpisodes: EpisodesByPodcast) -> Int {
        let request: NSFetchRequest<QueueEpisode> = QueueEpisode.fetchRequest()
        let predicate = NSPredicate(format: "episodeID == %@", currentEpisodeInEpisodes.episodesByPodcast_EpisodeID ?? "")
        request.predicate = predicate
        request.fetchLimit = 1

        do {
            let requestResult = try context.fetch(request)
          
            for data in requestResult as! [NSManagedObject] {
                return data.value(forKey: "episodeTimePlayed") as! Int
            }
        
        } catch {
            debugPrint("Error saving context \(error)")
        }
        
        return 0
    
    }
    
    func addPlayedEpisodeToQueueToCoreData() {
        let newPlayedEpisodeToQueue = QueueEpisode(context: self.context)
        newPlayedEpisodeToQueue.episodeIconURL = self.episodeByPodcast?.episodesByPodcast_PodcastIconURL
        newPlayedEpisodeToQueue.episodeID = self.episodeByPodcast?.episodesByPodcast_EpisodeID
        newPlayedEpisodeToQueue.episodeURL = self.episodeByPodcast?.episodesByPodcast_EpsiodeURL
        newPlayedEpisodeToQueue.episodeDescription = self.episodeByPodcast?.episodesByPodcast_EpisodeDescription
        newPlayedEpisodeToQueue.episodeName = self.episodeByPodcast?.episodesByPodcast_EpisodeName
        newPlayedEpisodeToQueue.episodeLength = 0 //Int16(self.episodeByPodcast?.episodesByPodcast_EpisodeLength)
        newPlayedEpisodeToQueue.episodeTimePlayed = 0
        newPlayedEpisodeToQueue.episodeMarkedAsPlayed = false
        newPlayedEpisodeToQueue.episodePubDateMS = 0 //Int16(self.episodeByPodcast?.episodesByPodcast_PubDateMS)
    
        do {
            try context.save()
            
            let alertView = SPAlertView(title: "Added to queue", message: nil, preset: SPAlertPreset.done)
            alertView.duration = 1
            alertView.dismissByTap = false
            alertView.haptic = .success
            alertView.present()
            
            self.dismiss(animated: true, completion: nil)
            
        } catch {
            debugPrint("Error saving context \(error)")
        }
    }
    
    @objc func closeAboutScreen() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addEpisodeToQueue() {
        addPlayedEpisodeToQueueToCoreData()
    }
    
    @objc func playEpisode() {
        performSegue(withIdentifier: "showPlayingNowVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlayingNowVC {
            destination.episodeByPodcast = episodeByPodcast
        }
    }
    
}
