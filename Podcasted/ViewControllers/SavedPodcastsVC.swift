//
//  SavedPodcastsVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 25/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SPAlert

class SavedPodcastsVC: UITableViewController {
    
    @IBOutlet var tableView_SavedPodcasts: UITableView!
    
    var savedPodcastsArray: [SavedPodcast] = []
    var currentSavedPodcastsArray: [SavedPodcast] = []
    
    var currenetSelectedSortOption: SortBySavedPodcasts?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let searchController = UISearchController(searchResultsController: nil)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavBar()
        setupSelectedSortOption()
        setupSearchInNavBar()
        setupAddedPodcastObserver()
        
        loadPodcastsFromCoreDataStore()
        
        //setupNotificationRequest()
        //setupTestNotification()
    }
    
    func setupNotificationRequest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
            (granted, error) in
            if granted {
                print("yes")
            } else {
                print("No")
            }
        }
    }
    
    func setupAddedPodcastObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableViewAfterAddedPodcast), name: .addedPodcastFromSearch, object: nil)
    }
    
    @objc func reloadTableViewAfterAddedPodcast(notification: NSNotification) {
        DispatchQueue.main.async {
            self.loadPodcastsFromCoreDataStore()
            self.tableView_SavedPodcasts.reloadData()
        }
    }
    
    func setupTestNotification() {
        let manager = NotificationManager()
        manager.notifications = [
            UserNotification(id: "Test 1", title: "Content for test 1, 10 seconds", datetime: DateComponents(second: 10)),
            UserNotification(id: "Test 2", title: "Content for test 2, 20 seconds", datetime: DateComponents(second: 20)),
            UserNotification(id: "Test 3", title: "Content for test 3, 30 seconds", datetime: DateComponents(second: 30))
        ]

        manager.schedule()
        
        /*
        let content = UNMutableNotificationContent()
        content.title = "Podcasted Neo"
        //content.subtitle = ""
        content.body = "Test notification"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)*/
    }
    
    func setupNavBar() {
        let filtersBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: #selector(showFilters))
        self.navigationItem.rightBarButtonItem  = filtersBarButtonItem
    }
    
    func setupTableView() {
        tableView_SavedPodcasts.delegate = self
        tableView_SavedPodcasts.dataSource = self
        
        self.tableView_SavedPodcasts.tableFooterView = UIView(frame: .zero)
    }
    
    func setupSearchInNavBar() {
        searchController.searchBar.delegate = self
        
        searchController.searchBar.placeholder = "Search for a saved podcast"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func loadPodcastsFromCoreDataStore() {
        let request: NSFetchRequest<SavedPodcast> = SavedPodcast.fetchRequest()
         do {
         savedPodcastsArray = try context.fetch(request)
            
            if !self.currentSavedPodcastsArray.isEmpty {
                self.currentSavedPodcastsArray.removeAll()
            }
            
            self.currentSavedPodcastsArray = savedPodcastsArray
            
            // TODO: Check if array.count is 0 / no podcasts was found in Core Data. Incase of no podcasts, hide tableview and show a message that indicates no podcasts was saved.
            // TODO: self.tableView_SavedPodcasts.isHidden = true
            
         } catch {
             debugPrint("Error fetching data from context \(error)")
         }
    }
    
    @objc func showFilters() {
        performSegue(withIdentifier: "showPodcastsFilterVC", sender: self)
    }
    
    func setupSelectedSortOption() {
        self.currenetSelectedSortOption = .SortByDateAdded
    }
    
    func sortSavedPodcastsArrayViaSortByOption(selectedSortByOption: SortBySavedPodcasts) {
        switch selectedSortByOption {
        case .SortByPodcastName:            
            let sortedPodcastNamesArray = self.currentSavedPodcastsArray.sorted(by: { $0.podcastName!.lowercased() < $1.podcastName!.lowercased() })
            
            self.currentSavedPodcastsArray = sortedPodcastNamesArray
                
            DispatchQueue.main.async {
               self.tableView_SavedPodcasts.reloadData()
            }
            
            self.currenetSelectedSortOption = .SortByPodcastName
        case .SortByDateAdded:
            loadPodcastsFromCoreDataStore()
            
            self.currenetSelectedSortOption = .SortByDateAdded
        default: break
        }
    }
    
    @IBAction func unwindToSavedPodcastsVC(_ sender: UIStoryboardSegue) {}
    
}

extension SavedPodcastsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentSavedPodcastsArray = savedPodcastsArray
            tableView_SavedPodcasts.reloadData()
            return
        }
        
        currentSavedPodcastsArray = savedPodcastsArray.filter({ (Podcast) -> Bool in
            Podcast.podcastName!.lowercased().contains(searchText.lowercased())
        })
        tableView_SavedPodcasts.reloadData()
        
    }
}

extension SavedPodcastsVC {
    override func tableView(_ tableView_SavedPodcasts: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let DeleteAction = UIContextualAction(style: .destructive, title: "Unfavorite podcast", handler: { (action, view, success) in
            
            let savedPodcastToDelete = self.currentSavedPodcastsArray[indexPath.row]
            self.context.delete(savedPodcastToDelete)
            self.currentSavedPodcastsArray.remove(at: indexPath.row)
            
            let alertView = SPAlertView(title: "Success", message: "Removed \(savedPodcastToDelete.podcastName ?? " podcast")", preset: SPAlertPreset.done)
            alertView.duration = 1
            alertView.dismissByTap = false
            alertView.haptic = .success
            alertView.present()
            
            do {
                                
              try self.context.save()
                
                DispatchQueue.main.async {
                   self.tableView_SavedPodcasts.reloadData()
                }
                
            } catch {
              debugPrint("Error fetching data from context \(error)")
            }
        })
        
        DeleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [DeleteAction])
    }
    
    override func tableView(_ tableView_SavedPodcasts: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSavedPodcastsArray.count
    }
    
    override func tableView(_ tableView_SavedPodcasts: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_SavedPodcasts.dequeueReusableCell(withIdentifier: "savedPodcastsCellIdentifier", for: indexPath) as! SavedPodcastsTableViewCell
        
        cell.Label_PodcastName.text = currentSavedPodcastsArray[indexPath.row].podcastName
        
        let podcastIconImageURL = URL(string: currentSavedPodcastsArray[indexPath.row].podcastIconURL ?? "")
        cell.ImageView_PodcastIcon.sd_setImage(with: podcastIconImageURL)
        
        return cell
    }
    
    override func tableView(_ tableView_SavedPodcasts: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEpisodesByPodcastVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesByPodcastVC {
            var podcastFromSavedPodcasts = currentSavedPodcastsArray[(tableView_SavedPodcasts.indexPathForSelectedRow?.row)!]
            
            var savedPodcastToEpsiodes: SavedPodcasts = SavedPodcasts(savedPodcast_Icon: nil, savedPodcast_PodcastID: podcastFromSavedPodcasts.podcastID, savedPodcast_PodcastName: podcastFromSavedPodcasts.podcastName, savedPodcast_PodcastDescription: podcastFromSavedPodcasts.podcastDescription)
            
            destination.savedPodcast = savedPodcastToEpsiodes
            tableView_SavedPodcasts.deselectRow(at: tableView_SavedPodcasts.indexPathForSelectedRow!, animated: true)
        }
        
        if let destination = segue.destination as? SavedPodcastsFilterVC {
            destination.currenetSelectedSortOption = self.currenetSelectedSortOption
        }
    }
}
