//
//  SortBySavedPodcasts.swift
//  Podcasted
//
//  Created by Ali Moussa on 16/10/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation

enum SortBySavedPodcasts {
    case SortByPodcastName
    case SortByDateAdded
    
    func getSelectedSortBySavedPodcastsOptionAsString(sortBySavedPodcastsSelectedOption: SortBySavedPodcasts) -> String {
        switch sortBySavedPodcastsSelectedOption {
        case .SortByPodcastName:
            return "Podcast Name"
        case .SortByDateAdded:
            return "Date Added"
        default: break
        }
    }
}
