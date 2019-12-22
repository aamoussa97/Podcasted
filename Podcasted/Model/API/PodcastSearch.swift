//
//  PodcastSearch.swift
//  Podcasted
//
//  Created by Ali Moussa on 28/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PodcastSearch {

    class func getPodcastSearch(searchQuery: String, completion: @escaping (_ searchQueryPodcast: [SearchPodcast])-> Void) {
        
        let headers: HTTPHeaders = [
            "X-ListenAPI-Key": "ListenNotesAPIKEY",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let url = "https://listen-api.listennotes.com/api/v2/search?q=\(searchQuery ?? "")&type=podcast&offset=0&safe_mode=0"
        
        AF.request(url, headers: headers)
            .response { response in
                
                var searchQueryArray: [SearchPodcast] = []
                
                switch response.result {
                case let .success(value):
                    
                    let json = JSON(value)
                    
                    if let searchPodcastsJSON = json["results"] as? JSON {
                        
                        for (index, searchPodcast):(String, JSON) in searchPodcastsJSON {
                            searchQueryArray.append(SearchPodcast(searchPodcast_Icon: nil, searchPodcast_PodcastIconURL: searchPodcast["thumbnail"].stringValue, searchPodcast_PodcastID: searchPodcast["id"].stringValue,searchPodcast_PodcastName: searchPodcast["title_original"].stringValue, searchPodcast_PodcastDescription: searchPodcast["description_original"].stringValue))/*, searchPodcast_GenreIDs: searchPodcast["genre_ids"].array))*/
                        }
                        
                    }
                    
                    completion(searchQueryArray)
                    
                case let .failure(error):
                    completion(searchQueryArray)
                    print("An error has occurred!")
                }
                
        }
        
    }
    
}
