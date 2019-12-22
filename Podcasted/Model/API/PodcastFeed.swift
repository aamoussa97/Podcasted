//
//  PodcastFeed.swift
//  Podcasted
//
//  Created by Ali Moussa on 28/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PodcastFeed {
    
    class func getPodcastFeed(implodedSavedPodcastIDsArray: String, completion: @escaping (_ feedNewReleases: [Feed_NewReleases])-> Void) {
        let headers: HTTPHeaders = [
            "X-ListenAPI-Key": "ListenNotesAPIKEY",
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json"
        ]
        
        var podcastIDs = implodedSavedPodcastIDsArray
        
        let parameters = [
            "ids": podcastIDs,
            "show_latest_episodes": "1"
        ]
        
        let url = "https://listen-api.listennotes.com/api/v2/podcasts"
        
        AF.request(url, method: .post, parameters: parameters, headers: headers)
            .response { response in
                
                var feedNewReleasesArray: [Feed_NewReleases] = []
                var podcastsFromFeedArray: [Feed_Podcasts] = []
                
                switch response.result {
                case let .success(value):
                    
                    let json = JSON(value)
                    
                    if let latestPodcastsJSON = json["podcasts"] as? JSON {
                        
                        for (index, podcast):(String, JSON) in latestPodcastsJSON {
                            podcastsFromFeedArray.append(Feed_Podcasts(FeedPodcasts_PodcastID: podcast["id"].stringValue, FeedPodcasts_PodcastIconURL: podcast["image"].stringValue))
                        }
                        
                    }
                    
                    if let latestEpisodesJSON = json["latest_episodes"] as? JSON {
                        
                        for (index, episode):(String, JSON) in latestEpisodesJSON {
                            
                            var podcastIconURL: String!
                            
                            for (index, podcast) in podcastsFromFeedArray.enumerated() {
                                if podcast.FeedPodcasts_PodcastID == episode["podcast_id"].stringValue {
                                    podcastIconURL = podcast.FeedPodcasts_PodcastIconURL
                                }
                            }
                            
                            feedNewReleasesArray.append(Feed_NewReleases(feedNewRelease_Icon: nil, feedNewRelease_PodcastIconURL: podcastIconURL, feedNewRelease_PodcastID: episode["podcast_id"].stringValue, feedNewRelease_PodcastEpisodeID: episode["id"].stringValue, feedNewRelease_PodcastEpisodeName: episode["title"].stringValue, feedNewRelease_PodcastName: episode["podcast_title"].stringValue, feedNewRelease_PodcastDescription: episode["description"].stringValue, feedNewRelease_PodcastLength: episode["audio_length_sec"].int, feedNewRelease_PodcastPubMS: episode["pub_date_ms"].int, feedNewRelease_PodcastURL: episode["audio"].stringValue))
                        }
                        
                    }
                    
                    completion(feedNewReleasesArray)
                    
                case let .failure(error):
                    completion(feedNewReleasesArray)
                    print("An error has occurred!")
                }
                
        }
        
    }
    
}
