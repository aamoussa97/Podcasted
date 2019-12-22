//
//  SortByFeed.swift
//  Podcasted
//
//  Created by Ali Moussa on 16/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation

enum SortByFeed {
    case SortByPodcastName
    case SortByEpisodeName
    case SortByNewestToOldest
    case SortByOldestToNewest
    
    func getSelectedSortByFeedOptionAsString(sortByFeedSelectedOption: SortByFeed) -> String {
        switch sortByFeedSelectedOption {
        case .SortByPodcastName:
            return "Podcast Name"
        case .SortByEpisodeName:
            return "Episode Name"
        case .SortByNewestToOldest:
            return "Newest to oldest"
        case .SortByOldestToNewest:
            return "Oldest to newest"
        default: break
        }
    }
}
