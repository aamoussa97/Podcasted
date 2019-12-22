//
//  DownloadsVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 27/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SPAlert

class DownloadsVC: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var downloadedEpisodesArray: [DownloadedEpisode] = []
    var currentdownloadedEpisodesArray: [DownloadedEpisode] = []
    
    var indexFromPlayClick: Int!
    
    @IBOutlet var tableView_DownloadedEpisodes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        setupSearchInNavBar()
        
        loadDownloadedEpisodesFromCoreDataStore()
    }
    
    func setupNavBar() {
        let settingsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(showSettings))
        self.navigationItem.rightBarButtonItem  = settingsBarButtonItem
    }
    
    func setupTableView() {
        tableView_DownloadedEpisodes.delegate = self
        tableView_DownloadedEpisodes.dataSource = self
        
        self.tableView_DownloadedEpisodes.tableFooterView = UIView(frame: .zero)
    }
    
    func loadDownloadedEpisodesFromCoreDataStore() {
        let request: NSFetchRequest<DownloadedEpisode> = DownloadedEpisode.fetchRequest()
         do {
         downloadedEpisodesArray = try context.fetch(request)
            
            if !self.currentdownloadedEpisodesArray.isEmpty {
                self.currentdownloadedEpisodesArray.removeAll()
            }
            
            self.currentdownloadedEpisodesArray = downloadedEpisodesArray
            
            // TODO: Check if array.count is 0 / no podcasts was found in Core Data. Incase of no downloaded episodes, hide tableview and show a message that indicates no podcasts was saved.
            // TODO: self.tableView_SavedPodcasts.isHidden = true
            
         } catch {
             debugPrint("Error fetching data from context \(error)")
         }
    }
    
    func playPodcastFromDownloadedEpisodes(index: Int) {
        self.indexFromPlayClick = index
        
        performSegue(withIdentifier: "showPlayingNowVC", sender: self)
    }
    
    @objc func showSettings() {
        performSegue(withIdentifier: "showSettingsVC", sender: self)
    }
    
    func calculateRemainingTimeOfEpisode(currentEpisodeInDownloads: DownloadedEpisode) -> Int {
        let request: NSFetchRequest<QueueEpisode> = QueueEpisode.fetchRequest()
        let predicate = NSPredicate(format: "episodeID == %@", currentEpisodeInDownloads.episodeID ?? "")
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
    
    func deleteDownloadedEpisodeFromLocalStorage(downloadedEpisodeToDelete: DownloadedEpisode?) {
        guard let fileURL = URL(string: downloadedEpisodeToDelete?.episodePathLocal ?? "") else { return }
        let fileName = fileURL.lastPathComponent
        
        guard var trueDocumentsLocation = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        trueDocumentsLocation.appendPathComponent(fileName)
        
        do {
            try? FileManager.default.removeItem(at: trueDocumentsLocation)
            } catch {
            debugPrint("Error fetching data from context \(error)")
        }
    }
}

extension DownloadsVC: UISearchBarDelegate {
    func setupSearchInNavBar() {
        searchController.searchBar.delegate = self
        
        searchController.searchBar.placeholder = "Search for an episode by name"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

extension DownloadsVC: PodcastCellPlay {
    func onClickPlayPodcast(index: Int) {
        playPodcastFromDownloadedEpisodes(index: index)
    }
}

extension DownloadsVC {
    override func tableView(_ tableView_DownloadedEpisodes: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let DeleteAction = UIContextualAction(style: .destructive, title: "Delete downloaded episode", handler: { (action, view, success) in
            
            let downloadedEpisodeToDelete = self.currentdownloadedEpisodesArray[indexPath.row]
            self.context.delete(downloadedEpisodeToDelete)
            self.currentdownloadedEpisodesArray.remove(at: indexPath.row)
            
            self.deleteDownloadedEpisodeFromLocalStorage(downloadedEpisodeToDelete: downloadedEpisodeToDelete)
            
            let alertView = SPAlertView(title: "Success", message: "Removed \(downloadedEpisodeToDelete.episodeName ?? " podcast")", preset: SPAlertPreset.done)
            alertView.duration = 1
            alertView.dismissByTap = false
            alertView.haptic = .success
            alertView.present()
            
            do {
                                
              try self.context.save()
                
                DispatchQueue.main.async {
                   self.tableView_DownloadedEpisodes.reloadData()
                }
                
            } catch {
              debugPrint("Error fetching data from context \(error)")
            }
             
        })
        
        DeleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [DeleteAction])
    }
    
    override func tableView(_ tableView_DownloadedEpisodes: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentdownloadedEpisodesArray.count
    }
    
    override func tableView(_ tableView_SavedPodcasts: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_DownloadedEpisodes.dequeueReusableCell(withIdentifier: "downloadedEpisodesCellIdentifier", for: indexPath) as! DownloadedEpisodesTableViewCell
                
        cell.Label_EpisodeName.text = currentdownloadedEpisodesArray[indexPath.row].episodeName ?? ""
        
        let podcastLengthInMinutes = Int(currentdownloadedEpisodesArray[indexPath.row].episodeLength) / 60
        var podcastRemainingTimeOfEpiosdeInMinutes = calculateRemainingTimeOfEpisode(currentEpisodeInDownloads: currentdownloadedEpisodesArray[indexPath.row])
        podcastRemainingTimeOfEpiosdeInMinutes = Int(podcastRemainingTimeOfEpiosdeInMinutes) / 60
        let timeRemainingOfEpisodeOrPodcastLength = podcastLengthInMinutes - (podcastRemainingTimeOfEpiosdeInMinutes)
        cell.Label_PodcastLength.text = "\(timeRemainingOfEpisodeOrPodcastLength)m"
        //cell.Label_PodcastLength.text = "\(currentdownloadedEpisodesArray[indexPath.row].episodeLength ?? 0)"
        //cell.Label_PodcastName.text = currentdownloadedEpisodesArray[indexPath.row].episodeName
        
        let podcastIconImageURL = URL(string: currentdownloadedEpisodesArray[indexPath.row].episodeIconURL ?? "")
        cell.ImageView_PodcastIcon.sd_setImage(with: podcastIconImageURL)
        
        cell.cellDelegate = self
        cell.index = indexPath
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavVC = segue.destination as? UINavigationController, let destinationVC = destinationNavVC.topViewController as? AboutEpisodeVC {
            var downloaded_Episode: DownloadedEpisode = currentdownloadedEpisodesArray[self.indexFromPlayClick]
                        
            var episodeByPodcast: EpisodesByPodcast = EpisodesByPodcast(episodesByPodcast_Icon: nil, episodesByPodcast_PodcastIconURL: downloaded_Episode.episodeIconURL, episodesByPodcast_PodcastName: downloaded_Episode.episodeName, episodesByPodcast_EpisodeID: downloaded_Episode.episodeID, episodesByPodcast_EpisodeName: downloaded_Episode.episodeName, episodesByPodcast_EpisodeDescription: downloaded_Episode.description, episodesByPodcast_EpsiodeURL: downloaded_Episode.episodeURL, episodesByPodcast_EpisodePathLocal: downloaded_Episode.episodePathLocal, episodesByPodcast_EpisodeLength: Int(downloaded_Episode.episodeLength ?? 0), episodesByPodcast_PubDateMS: Int(downloaded_Episode.episodePubDateMS ?? 0))
            
            destinationVC.episodeByPodcast = episodeByPodcast
                        
            tableView_DownloadedEpisodes.deselectRow(at: tableView_DownloadedEpisodes.indexPathForSelectedRow!, animated: true)
        }
        
        if let destination = segue.destination as? PlayingNowVC {
            var downloaded_Episode: DownloadedEpisode = currentdownloadedEpisodesArray[self.indexFromPlayClick]
                        
            var episodeByPodcast: EpisodesByPodcast = EpisodesByPodcast(episodesByPodcast_Icon: nil, episodesByPodcast_PodcastIconURL: downloaded_Episode.episodeIconURL, episodesByPodcast_PodcastName: downloaded_Episode.episodeName ,episodesByPodcast_EpisodeID: downloaded_Episode.episodeID, episodesByPodcast_EpisodeName: downloaded_Episode.episodeName, episodesByPodcast_EpisodeDescription: downloaded_Episode.description, episodesByPodcast_EpsiodeURL: downloaded_Episode.episodeURL, episodesByPodcast_EpisodePathLocal: downloaded_Episode.episodePathLocal, episodesByPodcast_EpisodeLength: Int(downloaded_Episode.episodeLength ?? 0), episodesByPodcast_PubDateMS: Int(downloaded_Episode.episodePubDateMS ?? 0))

            destination.episodeByPodcast = episodeByPodcast
        }
        
    }
    
    override func tableView(_ tableView_DownloadedEpisodes: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "showAboutEpisodeVC", sender: self)
    }
    
}
