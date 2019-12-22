//
//  SearchVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 20/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SPAlert
import SDWebImage

class SearchVC: UITableViewController {
    
    @IBOutlet var tableView_SearchPodcast: UITableView!
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let searchController = UISearchController(searchResultsController: nil)
    
    var searchQueryArray: [SearchPodcast] = []
    var searchQuery: String?
    
    var keyboardSearchTimoutTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchInNavBar()
        //setupNavBar()
    }
    
    func setupTableView() {
        self.tableView_SearchPodcast.tableFooterView = UIView(frame: .zero)
    }
    
    func setupNavBar() {
        let filtersBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: #selector(showFilters))
        self.navigationItem.rightBarButtonItem  = filtersBarButtonItem
    }
    
    func getPodcastSearchFromAPI(for searchQuery: String) {
        PodcastSearch.getPodcastSearch(searchQuery: searchQuery) { (SearchPodcast) in
            self.searchQueryArray = SearchPodcast
            
            DispatchQueue.main.async {
               self.tableView_SearchPodcast.reloadData()
            }
        }
    }
    
    func savePodcastFromSearch(index: Int) {
        let newSavedPodcast = SavedPodcast(context: self.context)
        newSavedPodcast.podcastIconURL = searchQueryArray[index].searchPodcast_PodcastIconURL
        newSavedPodcast.podcastName = searchQueryArray[index].searchPodcast_PodcastName
        newSavedPodcast.podcastID = searchQueryArray[index].searchPodcast_PodcastID
        newSavedPodcast.podcastDescription = searchQueryArray[index].searchPodcast_PodcastDescription
        
        let resultsCount = checkAlreadyExistingPodcastFromSearch(podcastID: newSavedPodcast.podcastID ?? "")
        
        do {
            try context.save()
            
            let alertView = SPAlertView(title: "Success", message: "Added \(searchQueryArray[index].searchPodcast_PodcastName ?? " podcast")", preset: SPAlertPreset.done)
            alertView.duration = 1
            alertView.dismissByTap = false
            alertView.haptic = .success
            alertView.present()
            
            NotificationCenter.default.post(name: .addedPodcastFromSearch, object: nil)
        } catch {
            debugPrint("Error saving context \(error)")
        }
        
        /*
        if resultsCount == 0 {
            do {
                try context.save()
                let alert = UIAlertController(title: "Success", message: "Added \(searchQueryArray[index].searchPodcast_PodcastName ?? " podcast")", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                self.present(alert, animated: true)
            } catch {
                debugPrint("Error saving context \(error)")
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Podcast is already saved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            self.present(alert, animated: true)
        }*/
    
    }
    
    func checkAlreadyExistingPodcastFromSearch(podcastID: String) -> Int {
        var savedPodcastsArrayCheck: [SavedPodcast] = []
        
        let request: NSFetchRequest<SavedPodcast> = SavedPodcast.fetchRequest()
        
        request.predicate = NSPredicate(format: "podcastID MATCHES[cd] %@", podcastID)

        do {
            savedPodcastsArrayCheck = try context.fetch(request)
        } catch {
            debugPrint("Error fetching data from context \(error)")
        }
        
        return savedPodcastsArrayCheck.count
    }
    
    @objc func showFilters() {
        performSegue(withIdentifier: "showSearchPodcastsFilterVC", sender: self)
    }
    
}

extension SearchVC: UISearchBarDelegate {
    func setupSearchInNavBar() {
        searchController.searchBar.delegate = self
        
        searchController.searchBar.placeholder = "Search for a podcast by name, person, topic, genre ..."
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

extension SearchVC: PodcastCellSave {
    func onClickAddPodcast(index: Int) {
        savePodcastFromSearch(index: index)
    }
}

extension SearchVC {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQueryArray.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }
                
        let characterSet = CharacterSet(bitmapRepresentation: CharacterSet.urlPathAllowed.bitmapRepresentation)
        let textToSearchReplacedWithPercentEncoding = textToSearch.safeAddingPercentEncoding(withAllowedCharacters: characterSet)!
        let textToSearchReplacedWithPercentEncodingLowercased = textToSearchReplacedWithPercentEncoding.lowercased()
        
        keyboardSearchTimoutTimer.invalidate()
        keyboardSearchTimoutTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(runPodcastSearchFromAPI), userInfo: textToSearchReplacedWithPercentEncodingLowercased, repeats: false)
    }
    
    @objc func runPodcastSearchFromAPI() {
        getPodcastSearchFromAPI(for: keyboardSearchTimoutTimer.userInfo as! String)
        keyboardSearchTimoutTimer.invalidate()
    }
    
    override func tableView(_ tableView_SearchPodcast: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchQueryArray.count
    }
    
    override func tableView(_ tableView_SearchPodcast: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_SearchPodcast.dequeueReusableCell(withIdentifier: "searchCellIdentifier", for: indexPath) as! SearchTableViewCell
        
        cell.Label_PodcastName.text = searchQueryArray[indexPath.row].searchPodcast_PodcastName
        
        let podcastIconImageURL = URL(string: searchQueryArray[indexPath.row].searchPodcast_PodcastIconURL)
        cell.ImageView_PodcastIcon.sd_setImage(with: podcastIconImageURL)
        
        cell.cellDelegate = self
        cell.index = indexPath
        
        return cell
    }
    
    override func tableView(_ tableView_SearchPodcast: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEpisodesByPodcastVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesByPodcastVC {
            var searchPodcast: SearchPodcast = searchQueryArray[(tableView_SearchPodcast.indexPathForSelectedRow?.row)!]
            
            var searchedPodcast: SavedPodcasts = SavedPodcasts(savedPodcast_Icon: nil, savedPodcast_PodcastID: searchPodcast.searchPodcast_PodcastID, savedPodcast_PodcastName: searchPodcast.searchPodcast_PodcastName)
            
            destination.savedPodcast = searchedPodcast
                        
            tableView_SearchPodcast.deselectRow(at: tableView_SearchPodcast.indexPathForSelectedRow!, animated: true)
        }
    }
}
