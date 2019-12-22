//
//  PodcastTopTenByGenreRegion.swift
//  Podcasted
//
//  Created by Ali Moussa on 28/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PodcastTopTenByGenreRegion {
    
    class func getPodcastTopTenByGenreRegion(completion: @escaping (_ feedNewReleases: [Feed_NewReleases])-> Void) {
            let headers: HTTPHeaders = [
                "X-ListenAPI-Key": "ListenNotesAPIKEY",
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
            
            let url = "https://listen-api.listennotes.com/api/v2/best_podcasts?genre_id=99&region=dk&safe_mode=0"
            
            AF.request(url, headers: headers)
                .response { response in
                    
                    switch response.result {
                    case let .success(value):
                        
                        do {
                            // JSON recieved from response
                            let json = JSON(value as Any)
                                                    
                            let podcastsJSON = json["podcasts"]
                             
                            for (index, podcast):(String, JSON) in podcastsJSON {
                                //savedPodcastsArray.append(SavedPodcasts(savedPodcast_Icon: nil, savedPodcast_PodcastID: podcast["id"].stringValue, savedPodcast_PodcastName: podcast["title"].stringValue))
                            }
                            
                        }
                        
                    case .failure(_):
                        print("An error has occurred!")
                        debugPrint(response.error)
                    }
            }
    }
    
}
