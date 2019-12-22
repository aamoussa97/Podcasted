//
//  SavedPodcastsGridVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 25/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SPAlert

class SavedPodcastsGridVC: UICollectionViewController {
    
    @IBOutlet var collectionView_SavedPodcasts: UICollectionView!
    
    var savedPodcastsArray: [SavedPodcast] = []
    var currentSavedPodcastsArray: [SavedPodcast] = []
    
    var currenetSelectedSortOption: SortBySavedPodcasts?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let searchController = UISearchController(searchResultsController: nil)
        
    var savedPodcastsLayout: SavedPodcastsLayout?
    
    var indexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        //setupCollectionViewLayout()
        setupNavBar()
        setupSelectedSortOption()
        setupSearchInNavBar()
        
        loadPodcastsFromCoreDataStore()
    }
    
    func setupNavBar() {
        let filtersBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: #selector(showFilters))
        self.navigationItem.rightBarButtonItem  = filtersBarButtonItem
    }
    
    func setupCollectionView() {
        collectionView_SavedPodcasts.delegate = self
        collectionView_SavedPodcasts.dataSource = self
        collectionView_SavedPodcasts.register(SavedPodcastsCollectionViewCell.self, forCellWithReuseIdentifier: "savedPodcastsGridCellIdentifier")
        
        collectionView_SavedPodcasts.collectionViewLayout = setupCollectionViewLayout()
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
                self.collectionView_SavedPodcasts.reloadData()
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

extension SavedPodcastsGridVC {
    func makeContextMenu(indexPath: IndexPath) -> UIMenu {
        
        let unfavoritePodcast = UIAction(title: "Unfavorite podcast", image: UIImage(systemName: "delete.right")) { action in
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
                   self.collectionView_SavedPodcasts.reloadData()
                }
                
            } catch {
              debugPrint("Error fetching data from context \(error)")
            }
        }
    
        return UIMenu(title: "", children: [unfavoritePodcast])
    }
}

extension SavedPodcastsGridVC {
    // Advances in Collection View Layout https://developer.apple.com/videos/play/wwdc19/215/
    private func setupCollectionViewLayout() -> UICollectionViewLayout {
        var fractionalWidth: CGFloat?
        var fractionalHeight: CGFloat?
        
        switch savedPodcastsLayout {
        case .Grid:
            fractionalWidth = 0.25
        case .Compact:
            fractionalWidth = 0.3333
        case .List:
            fractionalWidth = 1
        default:
            fractionalWidth = 0.25
        }
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionalWidth ?? 0.25),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(fractionalWidth ?? 0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension SavedPodcastsGridVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentSavedPodcastsArray = savedPodcastsArray
            collectionView_SavedPodcasts.reloadData()
            return
        }
        
        currentSavedPodcastsArray = savedPodcastsArray.filter({ (Podcast) -> Bool in
            Podcast.podcastName!.lowercased().contains(searchText.lowercased())
        })
        collectionView_SavedPodcasts.reloadData()
        
    }
}

extension SavedPodcastsGridVC {
  
    override func collectionView(_ collectionView_SavedPodcasts: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentSavedPodcastsArray.count
    }
    
    override func collectionView(_ collectionView_SavedPodcasts: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView_SavedPodcasts.dequeueReusableCell(withReuseIdentifier: "savedPodcastsGridCellIdentifier", for: indexPath) as! SavedPodcastsCollectionViewCell

        let podcastIconImageURL = URL(string: currentSavedPodcastsArray[indexPath.row].podcastIconURL ?? "")
        cell.ImageView_PodcastIcon.sd_setImage(with: podcastIconImageURL)
        
        return cell
    }
    
    override func collectionView(_ collectionView_SavedPodcasts: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexPath = indexPath
        performSegue(withIdentifier: "showEpisodesByPodcastVC", sender: self)
    }
    
    override func collectionView(_ collectionView_SavedPodcasts: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in

            return self.makeContextMenu(indexPath: indexPath)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesByPodcastVC {
            
            if let cell = collectionView_SavedPodcasts.cellForItem(at: indexPath)
            {
                var podcastFromSavedPodcasts = self.currentSavedPodcastsArray[indexPath.item]
                
                var savedPodcastToEpsiodes: SavedPodcasts = SavedPodcasts(savedPodcast_Icon: nil, savedPodcast_PodcastID: podcastFromSavedPodcasts.podcastID, savedPodcast_PodcastName: podcastFromSavedPodcasts.podcastName, savedPodcast_PodcastDescription: podcastFromSavedPodcasts.podcastDescription)
                
                destination.savedPodcast = savedPodcastToEpsiodes
            }
        }
        
        if let destination = segue.destination as? SavedPodcastsFilterVC {
            destination.currenetSelectedSortOption = self.currenetSelectedSortOption
        }
    }
}
