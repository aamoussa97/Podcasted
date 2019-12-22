//
//  EpisodesByPodcastVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 24/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SPAlert
import AFDateHelper
import Alamofire

class EpisodesByPodcastVC: UIViewController {
    
    @IBOutlet weak var tableView_EpsiodesByPodcast: UITableView!
    
    var episodesByPodcastArray: [EpisodesByPodcast] = []
    var savedPodcast: SavedPodcasts?
    
    var indexFromPlayClick: Int!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchInNavBar()
        getPodcastEpisodesFromAPI()
    }
    
    func setupTableView() {
        tableView_EpsiodesByPodcast.delegate = self
        tableView_EpsiodesByPodcast.dataSource = self
        
        self.navigationItem.title = savedPodcast?.savedPodcast_PodcastName
    }
    
    func getPodcastEpisodesFromAPI() {
        PodcastEpisodes.getPodcastEpisodes(savedPodcast: savedPodcast) { (EpisodesByPodcast) in
            self.episodesByPodcastArray = EpisodesByPodcast
            
            DispatchQueue.main.async {
               self.tableView_EpsiodesByPodcast.reloadData()
            }
        }
    }
    
    func playPodcastFromFeed(index: Int) {
        self.indexFromPlayClick = index
        
        performSegue(withIdentifier: "showPlayingNowVC", sender: self)
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
    
    func addEpisodeToQueueToCoreData(episodeFromEpisodesByPodcast: EpisodesByPodcast?) {
        let newPlayedEpisodeToQueue = QueueEpisode(context: self.context)
        newPlayedEpisodeToQueue.episodeIconURL = episodeFromEpisodesByPodcast?.episodesByPodcast_PodcastIconURL
        newPlayedEpisodeToQueue.episodeID = episodeFromEpisodesByPodcast?.episodesByPodcast_EpisodeID
        newPlayedEpisodeToQueue.episodeURL = episodeFromEpisodesByPodcast?.episodesByPodcast_EpsiodeURL
        newPlayedEpisodeToQueue.episodeDescription = episodeFromEpisodesByPodcast?.episodesByPodcast_EpisodeDescription
        newPlayedEpisodeToQueue.episodeName = episodeFromEpisodesByPodcast?.episodesByPodcast_EpisodeName
        newPlayedEpisodeToQueue.episodeLength = Int64(episodeFromEpisodesByPodcast?.episodesByPodcast_EpisodeLength ?? 0) // 0
        newPlayedEpisodeToQueue.episodeTimePlayed = 0
        newPlayedEpisodeToQueue.episodeMarkedAsPlayed = false
        newPlayedEpisodeToQueue.episodePubDateMS = Int64(episodeFromEpisodesByPodcast?.episodesByPodcast_PubDateMS ?? 0) // 0
        
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
    
    func addDownloadedEpisodeToDownloadedEpisodesToCoreData(episodeFromEpisodesByPodcast: EpisodesByPodcast?, pathToDownloadedEpisode: String) {
        let newDownloadedEpisodeToDownloadedEpisodes = DownloadedEpisode(context: self.context)
        newDownloadedEpisodeToDownloadedEpisodes.episodeIconURL = episodeFromEpisodesByPodcast?.episodesByPodcast_PodcastIconURL
        newDownloadedEpisodeToDownloadedEpisodes.episodeID = episodeFromEpisodesByPodcast?.episodesByPodcast_EpisodeID
        newDownloadedEpisodeToDownloadedEpisodes.episodeURL = episodeFromEpisodesByPodcast?.episodesByPodcast_EpsiodeURL
        newDownloadedEpisodeToDownloadedEpisodes.episodePathLocal = pathToDownloadedEpisode
        newDownloadedEpisodeToDownloadedEpisodes.episodeDescription = episodeFromEpisodesByPodcast?.episodesByPodcast_EpisodeDescription
        newDownloadedEpisodeToDownloadedEpisodes.episodeName = episodeFromEpisodesByPodcast?.episodesByPodcast_EpisodeName
        newDownloadedEpisodeToDownloadedEpisodes.episodeLength = Int64(episodeFromEpisodesByPodcast?.episodesByPodcast_EpisodeLength ?? 0)
        newDownloadedEpisodeToDownloadedEpisodes.episodeTimePlayed = 0
        newDownloadedEpisodeToDownloadedEpisodes.episodeMarkedAsPlayed = false
        newDownloadedEpisodeToDownloadedEpisodes.episodePubDateMS = Int64(episodeFromEpisodesByPodcast?.episodesByPodcast_PubDateMS ?? 0)
                
        do {
            try context.save()
            
            let alertView = SPAlertView(title: "Success", message: "Downloaded \(episodeFromEpisodesByPodcast?.episodesByPodcast_EpisodeName ?? " episode")", preset: SPAlertPreset.done)
            alertView.duration = 1
            alertView.dismissByTap = false
            alertView.haptic = .success
            alertView.present()
        } catch {
            debugPrint("Error saving context \(error)")
        }
    }
    
    func downloadEpisode(episodeFromEpisodesByPodcast: EpisodesByPodcast?) {
        /*let fileName = episodeFromEpisodesByPodcast?.episodesByPodcast_EpisodeID ?? episodeFromEpisodesByPodcast?.episodesByPodcast_EpisodeName
    
        let destination: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent("\(fileName).mp3")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }*/
            
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
        
        let utilityQueue = DispatchQueue.global(qos: .utility)

        AF.download(episodeFromEpisodesByPodcast?.episodesByPodcast_EpsiodeURL ?? "", to: destination)
        
            .downloadProgress(queue: utilityQueue) { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
        
            .response { response in
            
                if response.error == nil, let urlPath = response.fileURL?.path {
                    debugPrint(urlPath)
                    
                    self.addDownloadedEpisodeToDownloadedEpisodesToCoreData(episodeFromEpisodesByPodcast: episodeFromEpisodesByPodcast, pathToDownloadedEpisode: urlPath)
                }
        
            }
    }
    
    
    
}

extension EpisodesByPodcastVC: UISearchBarDelegate {
    func setupSearchInNavBar() {
        searchController.searchBar.delegate = self
        
        searchController.searchBar.placeholder = "Search for a episode name or release date"
        searchController.hidesNavigationBarDuringPresentation = false
        //searchController.searchBar.tintColor = .systemPink
        //searchController.searchBar.barTintColor = .systemPink
        navigationItem.searchController = searchController
    }
}

extension EpisodesByPodcastVC {
    func makeContextMenu(indexPath: IndexPath) -> UIMenu {

        let episodeFromEpisodesByPodcast = self.episodesByPodcastArray[indexPath.row]
        
        let playEpisode = UIAction(title: "Play episode", image: UIImage(systemName: "play")) { action in
            self.playPodcastFromFeed(index: indexPath.row)
        }
        
        let addEpisodeToQueue = UIAction(title: "Add episode to queue", image: UIImage(systemName: "text.badge.plus")) { action in
            self.addEpisodeToQueueToCoreData(episodeFromEpisodesByPodcast: episodeFromEpisodesByPodcast)
        }
        
        let markEpisodeAsPlayed = UIAction(title: "Mark episode as played", image: UIImage(systemName: "text.badge.checkmark")) { action in
            //self.markEpisodeAsPlayedToPlayedEpisodesToCoreData(episodeFromFeed: episodeFromFeed)
        }
        
        let downloadEpisode = UIAction(title: "Download episode", image: UIImage(systemName: "square.and.arrow.down")) { action in
            self.downloadEpisode(episodeFromEpisodesByPodcast: episodeFromEpisodesByPodcast)
        }
    
        return UIMenu(title: "", children: [playEpisode, addEpisodeToQueue, markEpisodeAsPlayed, downloadEpisode])
    }
}

extension EpisodesByPodcastVC: PodcastCellPlay {
    func onClickPlayPodcast(index: Int) {
        playPodcastFromFeed(index: index)
    }
}

extension EpisodesByPodcastVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView_EpsiodesByPodcast: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesByPodcastArray.count
    }
    
    func tableView(_ tableView_EpsiodesByPodcast: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_EpsiodesByPodcast.dequeueReusableCell(withIdentifier: "episodesByPodcastCell", for: indexPath) as! EpisodesByPodcastTableViewCell
        
        cell.Label_EpisodePodcastName.text = episodesByPodcastArray[indexPath.row].episodesByPodcast_EpisodeName
        
        let pubDateInMS: Int = episodesByPodcastArray[indexPath.row].episodesByPodcast_PubDateMS ?? 0
        let pubDateInString = pubDateInMS.formatMSToDate(miliseconds: pubDateInMS)
        let pubDateInStringToDate = Date(fromString: pubDateInString, format: .custom("dd-MM-yyyy"))
        let pubDateInStringDateMonth = pubDateInStringToDate?.toString(format: .custom("d MMMM"))
        cell.Label_EpisodePodcastPublishedDate.text = pubDateInStringDateMonth
        
        let podcastLengthInMinutes = Int(episodesByPodcastArray[indexPath.row].episodesByPodcast_EpisodeLength) / 60
        var podcastRemainingTimeOfEpiosdeInMinutes = calculateRemainingTimeOfEpisode(currentEpisodeInEpisodes: episodesByPodcastArray[indexPath.row])
        podcastRemainingTimeOfEpiosdeInMinutes = Int(podcastRemainingTimeOfEpiosdeInMinutes) / 60
        let timeRemainingOfEpisodeOrPodcastLength = podcastLengthInMinutes - (podcastRemainingTimeOfEpiosdeInMinutes)
        
        cell.Label_EpisodePodcastLength.text = "\(timeRemainingOfEpisodeOrPodcastLength)m"
        
        cell.cellDelegate = self
        cell.index = indexPath
        
        return cell
    }
    
    func tableView(_ tableView_EpsiodesByPodcast: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAboutEpisodeVC", sender: self)
    }
    
    func tableView(_ tableView_EpsiodesByPodcast: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in

            return self.makeContextMenu(indexPath: indexPath)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavVC = segue.destination as? UINavigationController, let destinationVC = destinationNavVC.topViewController as? AboutEpisodeVC {
                var episodeByPodcastArray: EpisodesByPodcast = episodesByPodcastArray[(tableView_EpsiodesByPodcast.indexPathForSelectedRow?.row)!]
                
            var episodeByPodcast: EpisodesByPodcast = EpisodesByPodcast(episodesByPodcast_Icon: nil, episodesByPodcast_PodcastIconURL: episodeByPodcastArray.episodesByPodcast_PodcastIconURL, episodesByPodcast_PodcastName: episodeByPodcastArray.episodesByPodcast_PodcastName, episodesByPodcast_EpisodeID: episodeByPodcastArray.episodesByPodcast_EpisodeID, episodesByPodcast_EpisodeName: episodeByPodcastArray.episodesByPodcast_EpisodeName, episodesByPodcast_EpisodeDescription: episodeByPodcastArray.episodesByPodcast_EpisodeDescription, episodesByPodcast_EpsiodeURL: episodeByPodcastArray.episodesByPodcast_EpsiodeURL, episodesByPodcast_EpisodeLength: episodeByPodcastArray.episodesByPodcast_EpisodeLength, episodesByPodcast_PubDateMS: episodeByPodcastArray.episodesByPodcast_PubDateMS)
                
                destinationVC.episodeByPodcast = episodeByPodcast
                
                tableView_EpsiodesByPodcast.deselectRow(at: tableView_EpsiodesByPodcast.indexPathForSelectedRow!, animated: true)
            }
            
            if let destination = segue.destination as? PlayingNowVC {
                var episodeByPodcastArray: EpisodesByPodcast = episodesByPodcastArray[self.indexFromPlayClick]
                            
                var episodeByPodcast: EpisodesByPodcast = EpisodesByPodcast(episodesByPodcast_Icon: nil, episodesByPodcast_PodcastIconURL: episodeByPodcastArray.episodesByPodcast_PodcastIconURL, episodesByPodcast_PodcastName: episodeByPodcastArray.episodesByPodcast_PodcastName, episodesByPodcast_EpisodeID: episodeByPodcastArray.episodesByPodcast_EpisodeID, episodesByPodcast_EpisodeName: episodeByPodcastArray.episodesByPodcast_EpisodeName, episodesByPodcast_EpisodeDescription: episodeByPodcastArray.episodesByPodcast_EpisodeDescription, episodesByPodcast_EpsiodeURL: episodeByPodcastArray.episodesByPodcast_EpsiodeURL, episodesByPodcast_EpisodeLength: episodeByPodcastArray.episodesByPodcast_EpisodeLength, episodesByPodcast_PubDateMS: episodeByPodcastArray.episodesByPodcast_PubDateMS)

                destination.episodeByPodcast = episodeByPodcast
            }
    }
}
