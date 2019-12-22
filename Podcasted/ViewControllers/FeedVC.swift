//
//  FeedVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 19/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SPAlert
import Alamofire

class FeedVC: UITableViewController {
    
    @IBOutlet var tableView_FeedNewReleases: UITableView!
    
    var feedNewReleasesArray: [Feed_NewReleases] = []
    var currentFeedNewReleasesArray: [Feed_NewReleases] = []
    
    var currenetSelectedSortOption: SortByFeed?
    
    var episodesInQueueArray: [QueueEpisode] = []
    var savedPodcastsArray: [SavedPodcast] = []
    var savedPodcastIDsArray: [String] = []
    var savedPodcastIDs: String!
    
    var indexFromPlayClick: Int!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupTableView()
        setupSearchInNavBar()
        setupNavBar()
        setupSelectedSortOption()
        
        // checkNetworkConnection()
        
        loadPodcastsFromCoreDataStore()
        loadQueueEpisodesFromCoreDataStore()
        implodeSavedPodcastArray()
        getPodcastFeedFromAPI()
    }
    
    func checkNetworkConnection() {
        //NetworkPathManager.networkPathMonitor.currentPath.status == .satisfied
          
        if NetworkPathManager.networkPathMonitor.currentPath.status == .satisfied {
            SPAlert.present(message: "We're connected")
            print("We're connected!")
        } else {
            SPAlert.present(message: "No connection")
            print("No connection.")
        }
        
        /*
        if NetworkPathManager.networkPath.Status == .satisfied {
            SPAlert.present(message: "We're connected")
            print("We're connected!")
        } else {
            SPAlert.present(message: "No connection")
            print("No connection.")
        }*/
        
        /*
        NetworkPathManager.networkPathMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                SPAlert.present(message: "We're connected")
                
                print("We're connected!")
            } else {
                SPAlert.present(message: "No connection")
                
                print("No connection.")
            }

            print(path.isExpensive)
        }*/
    }
    
    func setupTableView() {
        tableView_FeedNewReleases.delegate = self
        tableView_FeedNewReleases.dataSource = self
        
        self.tableView_FeedNewReleases.tableFooterView = UIView(frame: .zero)
    }
    
    func setupNavBar() {
        let filtersBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: #selector(showFilters))
        self.navigationItem.rightBarButtonItem  = filtersBarButtonItem
    }
    
    func loadPodcastsFromCoreDataStore() {
        let request: NSFetchRequest<SavedPodcast> = SavedPodcast.fetchRequest()
        
        do {
            savedPodcastsArray = try context.fetch(request)
        } catch {
            debugPrint("Error fetching data from context \(error)")
        }
    }
    
    func loadQueueEpisodesFromCoreDataStore() {
        let request: NSFetchRequest<QueueEpisode> = QueueEpisode.fetchRequest()
        
        do {
            episodesInQueueArray = try context.fetch(request)
        } catch {
            debugPrint("Error fetching data from context \(error)")
        }
    }
    
    func calculateRemainingTimeOfEpisode(currentEpisodeInFeed: Feed_NewReleases) -> Int {
        let request: NSFetchRequest<QueueEpisode> = QueueEpisode.fetchRequest()
        let predicate = NSPredicate(format: "episodeID == %@", currentEpisodeInFeed.feedNewRelease_PodcastEpisodeID ?? "")
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
    
    func implodeSavedPodcastArray() {
        self.savedPodcastsArray.forEach { (SavedPodcast) in
            self.savedPodcastIDsArray.append(SavedPodcast.podcastID ?? "")
        }
        
        self.savedPodcastIDs = savedPodcastIDsArray.joined(separator: ",")
    }
    
    func getPodcastFeedFromAPI() {
        PodcastFeed.getPodcastFeed(implodedSavedPodcastIDsArray: self.savedPodcastIDs) { (Feed_NewReleases) in
            self.feedNewReleasesArray = Feed_NewReleases
            self.currentFeedNewReleasesArray = self.feedNewReleasesArray
            
            DispatchQueue.main.async {
               self.tableView_FeedNewReleases.reloadData()
            }
            
            // TODO: Check for missing internet connection.
            // TODO: Check if there is an error while fetching feed. Then show an alert.
        }
    }
    
    func playPodcastFromFeed(index: Int) {
        self.indexFromPlayClick = index
        
        performSegue(withIdentifier: "showPlayingNowVC", sender: self)
    }
    
    @objc func showFilters() {
        performSegue(withIdentifier: "showFeedEpisodesFilterVC", sender: self)
    }
    
    func addEpisodeToQueueToCoreData(episodeFromFeed: Feed_NewReleases?) {
        let newPlayedEpisodeToQueue = QueueEpisode(context: self.context)
        newPlayedEpisodeToQueue.episodeIconURL = episodeFromFeed?.feedNewRelease_PodcastIconURL
        newPlayedEpisodeToQueue.episodeID = episodeFromFeed?.feedNewRelease_PodcastEpisodeID
        newPlayedEpisodeToQueue.episodeURL = episodeFromFeed?.feedNewRelease_PodcastURL
        newPlayedEpisodeToQueue.episodeDescription = episodeFromFeed?.feedNewRelease_PodcastDescription
        newPlayedEpisodeToQueue.episodeName = episodeFromFeed?.feedNewRelease_PodcastEpisodeName
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
    
    func setupSelectedSortOption() {
        self.currenetSelectedSortOption = .SortByNewestToOldest
    }
    
    func sortFeedArrayViaSortByOption(selectedSortByOption: SortByFeed) {
        switch selectedSortByOption {
        case .SortByPodcastName:
            let sortedFeedArray = self.currentFeedNewReleasesArray.sorted(by: { $0.feedNewRelease_PodcastName.lowercased() < $1.feedNewRelease_PodcastName.lowercased() })
            
            self.currentFeedNewReleasesArray = sortedFeedArray
                
            DispatchQueue.main.async {
               self.tableView_FeedNewReleases.reloadData()
            }
            
            self.currenetSelectedSortOption = .SortByPodcastName
        case .SortByEpisodeName:
            let sortedFeedArray = self.currentFeedNewReleasesArray.sorted(by: { $0.feedNewRelease_PodcastEpisodeName.lowercased() < $1.feedNewRelease_PodcastEpisodeName.lowercased() })
            
            self.currentFeedNewReleasesArray = sortedFeedArray
                
            DispatchQueue.main.async {
               self.tableView_FeedNewReleases.reloadData()
            }
            
            self.currenetSelectedSortOption = .SortByEpisodeName
        case .SortByNewestToOldest:
            let sortedFeedArray = self.currentFeedNewReleasesArray.sorted(by: { $0.feedNewRelease_PodcastPubMS > $1.feedNewRelease_PodcastPubMS })
            
            self.currentFeedNewReleasesArray = sortedFeedArray
                
            DispatchQueue.main.async {
               self.tableView_FeedNewReleases.reloadData()
            }
            
            self.currenetSelectedSortOption = .SortByNewestToOldest
        case .SortByOldestToNewest:
            let sortedFeedArray = self.currentFeedNewReleasesArray.sorted(by: { $0.feedNewRelease_PodcastPubMS < $1.feedNewRelease_PodcastPubMS })
            
            self.currentFeedNewReleasesArray = sortedFeedArray
                
            DispatchQueue.main.async {
               self.tableView_FeedNewReleases.reloadData()
            }
            
            self.currenetSelectedSortOption = .SortByOldestToNewest
        default: break
        }
    }
    
    func downloadEpisode(episodeFromFeed: Feed_NewReleases?) {
        let fileName = episodeFromFeed?.feedNewRelease_PodcastEpisodeID ?? episodeFromFeed?.feedNewRelease_PodcastEpisodeName
    
        /*
        let destination: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent("\(fileName).mp3")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }*/
        
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
        
        let utilityQueue = DispatchQueue.global(qos: .utility)

        AF.download(episodeFromFeed?.feedNewRelease_PodcastURL ?? "", to: destination)
        
            .downloadProgress(queue: utilityQueue) { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
        
            .response { response in
            
                if response.error == nil, let urlPath = response.fileURL?.path {
                    debugPrint(urlPath)
                    
                    self.addDownloadedEpisodeToDownloadedEpisodesToCoreData(episodeFromFeed: episodeFromFeed, pathToDownloadedEpisode: urlPath)
                }
        
            }
    }
    
    func addDownloadedEpisodeToDownloadedEpisodesToCoreData(episodeFromFeed: Feed_NewReleases?, pathToDownloadedEpisode: String) {
        let newDownloadedEpisodeToDownloadedEpisodes = DownloadedEpisode(context: self.context)
        newDownloadedEpisodeToDownloadedEpisodes.episodeIconURL = episodeFromFeed?.feedNewRelease_PodcastIconURL
        newDownloadedEpisodeToDownloadedEpisodes.episodeID = episodeFromFeed?.feedNewRelease_PodcastEpisodeID
        newDownloadedEpisodeToDownloadedEpisodes.episodeURL = episodeFromFeed?.feedNewRelease_PodcastURL
        newDownloadedEpisodeToDownloadedEpisodes.episodePathLocal = pathToDownloadedEpisode
        newDownloadedEpisodeToDownloadedEpisodes.episodeDescription = episodeFromFeed?.feedNewRelease_PodcastDescription
        newDownloadedEpisodeToDownloadedEpisodes.episodeName = episodeFromFeed?.feedNewRelease_PodcastEpisodeName
        newDownloadedEpisodeToDownloadedEpisodes.episodeLength = Int64(episodeFromFeed?.feedNewRelease_PodcastLength ?? 0)
        newDownloadedEpisodeToDownloadedEpisodes.episodeTimePlayed = 0
        newDownloadedEpisodeToDownloadedEpisodes.episodeMarkedAsPlayed = false
        newDownloadedEpisodeToDownloadedEpisodes.episodePubDateMS = Int64(episodeFromFeed?.feedNewRelease_PodcastPubMS ?? 0)
                
        do {
            try context.save()
            
            let alertView = SPAlertView(title: "Success", message: "Downloaded \(episodeFromFeed?.feedNewRelease_PodcastEpisodeName ?? " episode")", preset: SPAlertPreset.done)
            alertView.duration = 1
            alertView.dismissByTap = false
            alertView.haptic = .success
            alertView.present()
        } catch {
            debugPrint("Error saving context \(error)")
        }
    }
    
    @IBAction func unwindToFeedVC(_ sender: UIStoryboardSegue) {}
    
}

extension FeedVC: UISearchBarDelegate {
    func setupSearchInNavBar() {
        searchController.searchBar.delegate = self
        
        searchController.searchBar.placeholder = "Search for an episode or podcast in feed"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentFeedNewReleasesArray = feedNewReleasesArray
            tableView_FeedNewReleases.reloadData()
            return
        }
        
        currentFeedNewReleasesArray = feedNewReleasesArray.filter({ (Feed) -> Bool in
            Feed.feedNewRelease_PodcastName.lowercased().contains(searchText.lowercased()) || Feed.feedNewRelease_PodcastEpisodeName.lowercased().contains(searchText.lowercased()) || Feed.feedNewRelease_PodcastDescription.lowercased().contains(searchText.lowercased())
        })
        tableView_FeedNewReleases.reloadData()
        
    }
}

extension FeedVC {
    func makeContextMenu(indexPath: IndexPath) -> UIMenu {

        let episodeFromFeed = self.feedNewReleasesArray[indexPath.row]
        
        let playEpisode = UIAction(title: "Play episode", image: UIImage(systemName: "play")) { action in
            self.playPodcastFromFeed(index: indexPath.row)
        }
        
        let addEpisodeToQueue = UIAction(title: "Add episode to queue", image: UIImage(systemName: "text.badge.plus")) { action in
            self.addEpisodeToQueueToCoreData(episodeFromFeed: episodeFromFeed)
        }
        
        let markEpisodeAsPlayed = UIAction(title: "Mark episode as played", image: UIImage(systemName: "text.badge.checkmark")) { action in
            //self.markEpisodeAsPlayedToPlayedEpisodesToCoreData(episodeFromFeed: episodeFromFeed)
        }
        
        let downloadEpisode = UIAction(title: "Download episode", image: UIImage(systemName: "square.and.arrow.down")) { action in
            self.downloadEpisode(episodeFromFeed: episodeFromFeed)
        }
    
        return UIMenu(title: "", children: [playEpisode, addEpisodeToQueue, markEpisodeAsPlayed, downloadEpisode])
    }
}

extension FeedVC: PodcastCellPlay {
    func onClickPlayPodcast(index: Int) {
        playPodcastFromFeed(index: index)
    }
}

extension FeedVC {
    override func tableView(_ tableView_FeedNewReleases: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentFeedNewReleasesArray.count
    }
    
    override func tableView(_ tableView_FeedNewReleases: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_FeedNewReleases.dequeueReusableCell(withIdentifier: "feedNewReleasesCell", for: indexPath) as! FeedTableViewCell
        
        let pubDateInMS: Int = currentFeedNewReleasesArray[indexPath.row].feedNewRelease_PodcastPubMS ?? 0
        let pubDateInString = pubDateInMS.formatMSToDate(miliseconds: pubDateInMS)
        let pubDateInStringToDate = Date(fromString: pubDateInString, format: .custom("dd-MM-yyyy"))
        let pubDateInStringRelative = pubDateInStringToDate?.toStringWithRelativeTime() ?? ""
        
        cell.Label_PodcastName.text = currentFeedNewReleasesArray[indexPath.row].feedNewRelease_PodcastName
        cell.Label_EpisodeName.text = currentFeedNewReleasesArray[indexPath.row].feedNewRelease_PodcastEpisodeName
        
        let podcastLengthInMinutes = Int(currentFeedNewReleasesArray[indexPath.row].feedNewRelease_PodcastLength) / 60
        var podcastRemainingTimeOfEpiosdeInMinutes = calculateRemainingTimeOfEpisode(currentEpisodeInFeed: currentFeedNewReleasesArray[indexPath.row])
        podcastRemainingTimeOfEpiosdeInMinutes = Int(podcastRemainingTimeOfEpiosdeInMinutes) / 60
        let timeRemainingOfEpisodeOrPodcastLength = podcastLengthInMinutes - (podcastRemainingTimeOfEpiosdeInMinutes)
        cell.Label_PodcastLength.text = "\(timeRemainingOfEpisodeOrPodcastLength)m"
        
        let podcastIconImageURL = URL(string: currentFeedNewReleasesArray[indexPath.row].feedNewRelease_PodcastIconURL ?? "")
        cell.ImageView_PodcastIcon.sd_setImage(with: podcastIconImageURL)
                
        cell.cellDelegate = self
        cell.index = indexPath
        
        return cell
    }
    
    override func tableView(_ tableView_FeedNewReleases: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAboutEpisodeVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavVC = segue.destination as? UINavigationController, let destinationVC = destinationNavVC.topViewController as? AboutEpisodeVC {
            var feed_NewReleases: Feed_NewReleases = currentFeedNewReleasesArray[(tableView_FeedNewReleases.indexPathForSelectedRow?.row)!]
            
            var episodeByPodcast: EpisodesByPodcast = EpisodesByPodcast(episodesByPodcast_Icon: nil, episodesByPodcast_PodcastIconURL: feed_NewReleases.feedNewRelease_PodcastIconURL, episodesByPodcast_PodcastName: feed_NewReleases.feedNewRelease_PodcastName ,episodesByPodcast_EpisodeID: feed_NewReleases.feedNewRelease_PodcastEpisodeID, episodesByPodcast_EpisodeName: feed_NewReleases.feedNewRelease_PodcastEpisodeName, episodesByPodcast_EpisodeDescription: feed_NewReleases.feedNewRelease_PodcastDescription, episodesByPodcast_EpsiodeURL: feed_NewReleases.feedNewRelease_PodcastURL, episodesByPodcast_EpisodeLength: feed_NewReleases.feedNewRelease_PodcastLength, episodesByPodcast_PubDateMS: feed_NewReleases.feedNewRelease_PodcastPubMS)
            
            destinationVC.episodeByPodcast = episodeByPodcast
                        
            tableView_FeedNewReleases.deselectRow(at: tableView_FeedNewReleases.indexPathForSelectedRow!, animated: true)
        }
        
        if let destination = segue.destination as? PlayingNowVC {
            var feed_NewReleases: Feed_NewReleases = currentFeedNewReleasesArray[self.indexFromPlayClick]
                        
            var episodeByPodcast: EpisodesByPodcast = EpisodesByPodcast(episodesByPodcast_Icon: nil, episodesByPodcast_PodcastIconURL: feed_NewReleases.feedNewRelease_PodcastIconURL, episodesByPodcast_PodcastName: feed_NewReleases.feedNewRelease_PodcastName ,episodesByPodcast_EpisodeID: feed_NewReleases.feedNewRelease_PodcastEpisodeID, episodesByPodcast_EpisodeName: feed_NewReleases.feedNewRelease_PodcastEpisodeName, episodesByPodcast_EpisodeDescription: feed_NewReleases.feedNewRelease_PodcastDescription, episodesByPodcast_EpsiodeURL: feed_NewReleases.feedNewRelease_PodcastURL, episodesByPodcast_EpisodeLength: feed_NewReleases.feedNewRelease_PodcastLength, episodesByPodcast_PubDateMS: feed_NewReleases.feedNewRelease_PodcastPubMS)

            destination.episodeByPodcast = episodeByPodcast
        }
        
        if let destination = segue.destination as? FeedEpisodesFilterVC {
            destination.currenetSelectedSortOption = self.currenetSelectedSortOption
        }
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in

            return self.makeContextMenu(indexPath: indexPath)
        })
    }
}
