//
//  PodcastEpisodes.swift
//  Podcasted
//
//  Created by Ali Moussa on 28/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PodcastEpisodes {

    class func getPodcastEpisodes(savedPodcast: SavedPodcasts?, completion: @escaping (_ episodesByPodcast: [EpisodesByPodcast])-> Void) {
        
        let headers: HTTPHeaders = [
            "X-ListenAPI-Key": "ListenNotesAPIKEY",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let url = "https://listen-api.listennotes.com/api/v2/podcasts/\(savedPodcast?.savedPodcast_PodcastID ?? "")?sort=recent_first"
        
        AF.request(url, headers: headers)
            .response { response in
                
                var episodesByPodcastArray: [EpisodesByPodcast] = []
                
                switch response.result {
                case let .success(value):
                    
                    let json = JSON(value)
                    
                    if let podcastsJSON = json["episodes"] as? JSON {
                        
                        let podcastIconURL = json["image"].stringValue
                        
                        for (index, podcastEpisode):(String, JSON) in podcastsJSON {
                            episodesByPodcastArray.append(EpisodesByPodcast(episodesByPodcast_Icon: nil, episodesByPodcast_PodcastIconURL: podcastIconURL, episodesByPodcast_PodcastName: json["title"].stringValue, episodesByPodcast_EpisodeID: podcastEpisode["id"].stringValue, episodesByPodcast_EpisodeName: podcastEpisode["title"].stringValue, episodesByPodcast_EpisodeDescription: podcastEpisode["description"].stringValue, episodesByPodcast_EpsiodeURL: podcastEpisode["audio"].stringValue, episodesByPodcast_EpisodeLength: podcastEpisode["audio_length_sec"].int, episodesByPodcast_PubDateMS: podcastEpisode["pub_date_ms"].int))
                        }
                        
                    }
                    
                    completion(episodesByPodcastArray)
                    
                case let .failure(error):
                    completion(episodesByPodcastArray)
                    print("An error has occurred!")
                }
                
        }
        
    }
    
}
