//
//  QueueVC.swift
//  Podcasted
//
//  Created by Ali Moussa on 11/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SPAlert

class QueueVC: UIViewController {
    
    @IBOutlet weak var tableView_QueueEpisodes: UITableView!
    
    @IBOutlet weak var UIView_BottomControlsQueue: UIView!
    @IBOutlet weak var Label_AmountOfEpisodes: UILabel!
    @IBOutlet weak var Button_ClearAllQueue: UIButton!
    
    @IBAction func Button_ClearAllQueue(_ sender: Any) {
        clearAllQueueEpisodesInCoreData()
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var queueEpisodesArray: [QueueEpisode] = []
    var currentPlayingEpisodeByPodcast: EpisodesByPodcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        
        setupCoreDataPolicy()
        loadQueueEpisodesToCoreData()
        
        setupBottomControls()
    }
    
    func setupNavBar() {
        let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(closeQueueScreen))
        let editBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editQueueEpisode))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        self.navigationItem.rightBarButtonItem = editBarButtonItem
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupCoreDataPolicy() {
        self.context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func setupBottomControls() {
        self.Button_ClearAllQueue.backgroundColor = .label
        self.Button_ClearAllQueue.setTitleColor(.systemBackground, for: .normal)
        self.Button_ClearAllQueue.layer.cornerRadius =  7
        self.Button_ClearAllQueue.setTitle("CLEAR ALL", for: .normal)
        
        self.UIView_BottomControlsQueue.backgroundColor = .systemBackground
        
        var queueEpisodesArrayTimeTotal = Int64()
        
        for queueEpisode in self.queueEpisodesArray {
            queueEpisodesArrayTimeTotal += queueEpisode.episodeLength
        }
        
        let queueEpisodesArrayTimeTotalFormatted = Double(queueEpisodesArrayTimeTotal)
        
        self.Label_AmountOfEpisodes.text = "\(self.queueEpisodesArray.count) EPISODES . \(queueEpisodesArrayTimeTotalFormatted.stringFromInterval())"
    }
    
    func setupTableView() {
        tableView_QueueEpisodes.delegate = self
        tableView_QueueEpisodes.dataSource = self
        
        self.tableView_QueueEpisodes.tableFooterView = UIView(frame: .zero)
    }
    
    @objc func closeQueueScreen() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func editQueueEpisode(_ sender: UIBarButtonItem) {
        self.tableView_QueueEpisodes.isEditing.toggle()
        sender.title = sender.title == "Edit" ? "Done" : "Edit"
    }
    
    func deleteQueueEpisodesToCoreData(indexPath: IndexPath) {
        let QueueEpisodeToDelete = self.queueEpisodesArray[indexPath.row]
        self.context.delete(QueueEpisodeToDelete)
        self.queueEpisodesArray.remove(at: indexPath.item)
        self.tableView_QueueEpisodes.deleteRows(at: [indexPath], with: .automatic)
        
        do {
                            
          try self.context.save()
            
            DispatchQueue.main.async {
               self.tableView_QueueEpisodes.reloadData()
            }
            
        } catch {
          debugPrint("Error fetching data from context \(error)")
        }
    }
    
    func loadQueueEpisodesToCoreData() {
        let request: NSFetchRequest<QueueEpisode> = QueueEpisode.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "episodeOrderPosition", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
         do {
         queueEpisodesArray = try context.fetch(request)
                        
         } catch {
             debugPrint("Error fetching data from context \(error)")
         }
    }
    
    func saveQueueEpisodesToCoreData(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        var queueEpisodesObjects = self.queueEpisodesArray
        
        let episodeFromQueueObject = queueEpisodesObjects[sourceIndexPath.row]
        queueEpisodesObjects.remove(at: sourceIndexPath.row)
        queueEpisodesObjects.insert(episodeFromQueueObject, at: destinationIndexPath.row)
        
        for (index, item) in queueEpisodesObjects.enumerated() {
            item.episodeOrderPosition = Int16(index)
        }
            
        do {
                            
          try self.context.save()

        } catch {
            debugPrint("Error saving context \(error)")
        }
    }
    
    func clearAllQueueEpisodesInCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "QueueEpisode")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            
            try context.execute(batchDeleteRequest)
            
            let alertView = SPAlertView(title: "Cleared queue", message: nil, preset: SPAlertPreset.done)
            alertView.duration = 1
            alertView.dismissByTap = false
            alertView.haptic = .success
            alertView.present()
            
            DispatchQueue.main.async {
               self.tableView_QueueEpisodes.reloadData()
            }
            
            self.dismiss(animated: true, completion: nil)

        } catch {
            debugPrint("Error fetching data from context \(error)")
        }

    }
    
}

extension QueueVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView_QueueEpisodes: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queueEpisodesArray.count
    }
    
    func tableView(_ tableView_QueueEpisodes: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_QueueEpisodes.dequeueReusableCell(withIdentifier: "queuedEpisodesCellIdentifier", for: indexPath) as! QueueEpisodesTableViewCell
        
        self.queueEpisodesArray[indexPath.row].setValue(indexPath.row, forKey: "episodeOrderPosition")
        
        cell.Label_EpisodeName.text = queueEpisodesArray[indexPath.row].episodeName
        
        if queueEpisodesArray[indexPath.row].episodeID == currentPlayingEpisodeByPodcast?.episodesByPodcast_EpisodeID {
            cell.backgroundColor = .lightGray
        }
        
        let pubDateInMS: Int = Int(queueEpisodesArray[indexPath.row].episodePubDateMS ?? 0)
        let pubDateInString = pubDateInMS.formatMSToDate(miliseconds: pubDateInMS)
        let pubDateInStringToDate = Date(fromString: pubDateInString, format: .custom("dd-MM-yyyy"))
        let pubDateInStringDateMonth = pubDateInStringToDate?.toString(format: .custom("d MMM"))
        cell.Label_EpisodeDate.text = pubDateInStringDateMonth
        
        var podcastLengthInMinutes = Int(queueEpisodesArray[indexPath.row].episodeLength) / 60
        var podcastRemainingTimeOfEpiosdeInMinutes = Int(queueEpisodesArray[indexPath.row].episodeTimePlayed) / 60
        let timeRemainingOfEpisode = podcastLengthInMinutes - podcastRemainingTimeOfEpiosdeInMinutes //queueEpisodesArray[indexPath.row].episodeLength - queueEpisodesArray[indexPath.row].episodeTimePlayed
        cell.Label_EpisodeTimeRemaining.text = "\(timeRemainingOfEpisode)m"
                
        let podcastIconImageURL = URL(string: queueEpisodesArray[indexPath.row].episodeIconURL ?? "URL")
        cell.ImageView_EpisodeIcon.sd_setImage(with: podcastIconImageURL)
        
        return cell
    }
    
    func tableView(_ tableView_QueueEpisodes: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView_QueueEpisodes.isEditing {
            return true
        }
        
        return false
    }
    
    func tableView(_ tableView_QueueEpisodes: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView_QueueEpisodes: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        saveQueueEpisodesToCoreData(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            deleteQueueEpisodesToCoreData(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView_QueueEpisodes: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Move selected cell to index 0 in array
        //Reload PlayingNowVC with new index 0 episode
    }
    
}
