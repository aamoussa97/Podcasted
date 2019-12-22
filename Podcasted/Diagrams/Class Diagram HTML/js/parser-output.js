var entities = [{
  "id": 1,
  "typeString": "class",
  "properties": [
    {
  "name": "let sharedProvider",
  "type": "type",
  "accessLevel": "internal"
},
    {
  "name": "var avPlayer:AVPlayer?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var avPlayerItem:AVPlayerItem?",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "init()",
  "type": "instance",
  "accessLevel": "private"
}
  ],
  "name": "AudioPlayerProvider"
},{
  "id": 2,
  "typeString": "struct",
  "properties": [
    {
  "name": "var id:String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var title:String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var datetime:DateComponents",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "Notification"
},{
  "id": 3,
  "typeString": "class",
  "properties": [
    {
  "name": "var notifications",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "requestAuthorization()",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "schedule()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "scheduleNotifications()",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "listScheduledNotifications()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "NotificationManager"
},{
  "id": 4,
  "typeString": "class",
  "properties": [
    {
  "name": "let networkPathMonitor",
  "type": "type",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "startNWPathMonitorWithQueue()",
  "type": "type",
  "accessLevel": "internal"
}
  ],
  "name": "NetworkPathManager"
},{
  "id": 8,
  "typeString": "class",
  "properties": [
    {
  "name": "var trackHeight: CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var thumbRadius: CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var thumbView: UIView",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let thumb",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "awakeFromNib()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "thumbImage(radius: CGFloat) -> UIImage",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "trackRect(forBounds bounds: CGRect) -> CGRect",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "CustomSlider",
  "superClass": 78
},{
  "id": 11,
  "typeString": "class",
  "properties": [
    {
  "name": "var tableView_SavedPodcasts: UITableView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcastsArray: [SavedPodcast]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var currentSavedPodcastsArray: [SavedPodcast]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var currenetSelectedSortOption: SortBySavedPodcasts?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let context",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let searchController",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupNotificationRequest()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupTestNotification()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupNavBar()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupTableView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupSearchInNavBar()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "loadPodcastsFromCoreDataStore()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showFilters()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupSelectedSortOption()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sortSavedPodcastsArrayViaSortByOption(selectedSortByOption: SortBySavedPodcasts)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "unwindToSavedPodcastsVC(_ sender: UIStoryboardSegue)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SavedPodcastsVC",
  "superClass": 79,
  "extensions": [
    12,
    13
  ]
},{
  "id": 14,
  "typeString": "class",
  "properties": [
    {
  "name": "var playbackVCTitleLabel",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var playbackStepperValueLabel",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var playbackRateStepper",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var buttonResetChanges",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var buttonSaveChanges",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var playbackRateActual",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var playbackRateTruncated",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addSubViews()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "stepperValueChanged(_ sender:UIStepper!)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "resetStepperValue()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "saveChangesFromStepperValue()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "shouldPopupDismissInteractivelty() -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupHeight() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupTopCornerRadius() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupPresentDuration() -> Double",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "PlaybackSpeedVC",
  "superClass": 80
},{
  "id": 15,
  "typeString": "class",
  "properties": [
    {
  "name": "var collectionView_SavedPodcasts: UICollectionView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcastsArray: [SavedPodcast]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var currentSavedPodcastsArray: [SavedPodcast]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var currenetSelectedSortOption: SortBySavedPodcasts?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let context",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let searchController",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcastsLayout: SavedPodcastsLayout?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var indexPath",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupNavBar()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupCollectionView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupSearchInNavBar()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "loadPodcastsFromCoreDataStore()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showFilters()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupSelectedSortOption()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sortSavedPodcastsArrayViaSortByOption(selectedSortByOption: SortBySavedPodcasts)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "unwindToSavedPodcastsVC(_ sender: UIStoryboardSegue)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SavedPodcastsGridVC",
  "superClass": 81,
  "extensions": [
    16,
    17,
    18,
    19
  ]
},{
  "id": 20,
  "typeString": "class",
  "properties": [
    {
  "name": "let appSharedDelegate",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var selectedSortByOption: SortByFeed? @objc @objc @objc @objc",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addSubViews()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sortByPodcastName()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sortByEpisodeName()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sortByNewestToOldest()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sortByOldestToNewest()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "shouldPopupDismissInteractivelty() -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupHeight() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupTopCornerRadius() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupPresentDuration() -> Double",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SortByFeedSubFilterVC",
  "superClass": 80
},{
  "id": 21,
  "typeString": "class",
  "properties": [
    {
  "name": "let appSharedDelegate",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var selectedSortByOption: SortBySavedPodcasts? @objc @objc",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addSubViews()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sortByPodcastName()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sortByDateAdded()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "shouldPopupDismissInteractivelty() -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupHeight() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupTopCornerRadius() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupPresentDuration() -> Double",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SortBySavedSubFilterVC",
  "superClass": 80
},{
  "id": 22,
  "typeString": "class",
  "properties": [
    {
  "name": "let appSharedDelegate",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var currenetSelectedSortOption: SortBySavedPodcasts?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcastsLayout: SavedPodcastsLayout?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let filterViewTypes",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var filterViewTypesSegmentedControl: UISegmentedControl",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let control",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "handleSegmentedControlValueChanged(_ sender: UISegmentedControl)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "image(with image: UIImage?, scaledTo newSize: CGSize) -> UIImage?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addSubViews()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sortByVC()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "shouldPopupDismissInteractivelty() -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupHeight() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupTopCornerRadius() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupPresentDuration() -> Double",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SavedPodcastsFilterVC",
  "superClass": 80
},{
  "id": 23,
  "typeString": "class",
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addSubViews()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "shouldPopupDismissInteractivelty() -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupHeight() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupTopCornerRadius() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupPresentDuration() -> Double",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SearchPodcastsFilterVC",
  "superClass": 80
},{
  "id": 24,
  "typeString": "class",
  "properties": [
    {
  "name": "var currenetSelectedSortOption: SortByFeed?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let appSharedDelegate",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addSubViews()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sortByVC()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "shouldPopupDismissInteractivelty() -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupHeight() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupTopCornerRadius() -> CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPopupPresentDuration() -> Double",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "FeedEpisodesFilterVC",
  "superClass": 80
},{
  "id": 25,
  "typeString": "class",
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "populate(_ builder: FormBuilder)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupNavBar()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showSettings()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SettingsVC",
  "superClass": 82
},{
  "id": 26,
  "typeString": "class",
  "properties": [
    {
  "name": "var tableView_SearchPodcast: UITableView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let context",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let searchController",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var searchQueryArray: [SearchPodcast]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var searchQuery: String?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var keyboardSearchTimoutTimer",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupTableView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupNavBar()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPodcastSearchFromAPI(for searchQuery: String)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "savePodcastFromSearch(index: Int)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "checkAlreadyExistingPodcastFromSearch(podcastID: String) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showFilters()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SearchVC",
  "superClass": 79,
  "extensions": [
    27,
    28,
    29
  ]
},{
  "id": 30,
  "typeString": "class",
  "properties": [
    {
  "name": "var playerSeekBackwards: StepperFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let instance",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var playerSeekFowards: StepperFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let instance",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var submitButton: ButtonFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let instance",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let playerSeekBackwardsValueFromStepper",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let playerSeekForwardsValueFromStepper",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var resetButton: ButtonFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let instance",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let playerSeekBackwardsResetDefault",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let playerSeekForwardsResetDefault",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "populate(_ builder: FormBuilder)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "loadSeekValuesFromUserDefaults() -> (Int, Int)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "saveSeekValuesToUserDefaults(seekBackwardValueFromStepper: Int, seekForwardValueFromStepper: Int)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SettingsPlayerVC",
  "superClass": 82
},{
  "id": 31,
  "typeString": "class",
  "properties": [
    {
  "name": "var slider0: PrecisionSliderFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let instance",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var slider1: PrecisionSliderFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let instance",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var slider2: PrecisionSliderFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let instance",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var colorPreview: StaticTextFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var colorSummary: StaticTextFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var useEmbeddedArtworkSwitch: SwitchFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let instance",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var submitButton: ButtonFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let instance",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var resetButton: ButtonFormItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let instance",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "populate(_ builder: FormBuilder)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "updateColorSummary()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "updateColorPreview()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "resetAppTintColorValuesToUserDefaults()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "saveAppTintColorValuesToUserDefaults()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SettingsAppearanceVC",
  "superClass": 82
},{
  "id": 32,
  "typeString": "class",
  "methods": [
    {
  "name": "populate(_ builder: FormBuilder)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SettingsAboutVC",
  "superClass": 82
},{
  "id": 33,
  "typeString": "class",
  "properties": [
    {
  "name": "var tableView_FeedNewReleases: UITableView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var feedNewReleasesArray: [Feed_NewReleases]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var currentFeedNewReleasesArray: [Feed_NewReleases]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var currenetSelectedSortOption: SortByFeed?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodesInQueueArray: [QueueEpisode]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcastsArray: [SavedPodcast]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcastIDsArray: [String]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcastIDs: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var indexFromPlayClick: Int!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let context",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let searchController",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "checkNetworkConnection()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupTableView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupNavBar()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "loadPodcastsFromCoreDataStore()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "loadQueueEpisodesFromCoreDataStore()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "calculateRemainingTimeOfEpisode(currentEpisodeInFeed: Feed_NewReleases) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "implodeSavedPodcastArray()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPodcastFeedFromAPI()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "playPodcastFromFeed(index: Int)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showFilters()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addEpisodeToQueueToCoreData(episodeFromFeed: Feed_NewReleases?)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupSelectedSortOption()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sortFeedArrayViaSortByOption(selectedSortByOption: SortByFeed)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "downloadEpisode(episodeFromFeed: Feed_NewReleases?)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addDownloadedEpisodeToDownloadedEpisodesToCoreData(episodeFromFeed: Feed_NewReleases?, pathToDownloadedEpisode: String)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "unwindToFeedVC(_ sender: UIStoryboardSegue)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "FeedVC",
  "superClass": 79,
  "extensions": [
    34,
    35,
    36,
    37
  ]
},{
  "id": 38,
  "typeString": "class",
  "properties": [
    {
  "name": "let context",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let searchController",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var downloadedEpisodesArray: [DownloadedEpisode]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var currentdownloadedEpisodesArray: [DownloadedEpisode]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var indexFromPlayClick: Int!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var tableView_DownloadedEpisodes: UITableView! @objc",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupNavBar()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupTableView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "loadDownloadedEpisodesFromCoreDataStore()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "playPodcastFromDownloadedEpisodes(index: Int)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showSettings()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "calculateRemainingTimeOfEpisode(currentEpisodeInDownloads: DownloadedEpisode) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "deleteDownloadedEpisodeFromLocalStorage(downloadedEpisodeToDelete: DownloadedEpisode?)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "DownloadsVC",
  "superClass": 79,
  "extensions": [
    39,
    40,
    41
  ]
},{
  "id": 42,
  "typeString": "class",
  "properties": [
    {
  "name": "var Label_PodcastEpisodeName: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_PodcastName: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var TextView_PodcastDescription: UITextView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let context",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodeByPodcast: EpisodesByPodcast? @objc @objc @objc",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupNavBar()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupAboutEpisodeView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "calculateRemainingTimeOfEpisode(currentEpisodeInEpisodes: EpisodesByPodcast) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addPlayedEpisodeToQueueToCoreData()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "closeAboutScreen()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addEpisodeToQueue()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "playEpisode()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "AboutEpisodeVC",
  "superClass": 83
},{
  "id": 43,
  "typeString": "class",
  "properties": [
    {
  "name": "var tableView_EpsiodesByPodcast: UITableView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodesByPodcastArray: [EpisodesByPodcast]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcast: SavedPodcasts?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var indexFromPlayClick: Int!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let searchController",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let context",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupTableView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getPodcastEpisodesFromAPI()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "playPodcastFromFeed(index: Int)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "calculateRemainingTimeOfEpisode(currentEpisodeInEpisodes: EpisodesByPodcast) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addEpisodeToQueueToCoreData(episodeFromEpisodesByPodcast: EpisodesByPodcast?)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addDownloadedEpisodeToDownloadedEpisodesToCoreData(episodeFromEpisodesByPodcast: EpisodesByPodcast?, pathToDownloadedEpisode: String)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "downloadEpisode(episodeFromEpisodesByPodcast: EpisodesByPodcast?)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "EpisodesByPodcastVC",
  "superClass": 83,
  "extensions": [
    44,
    45,
    46,
    47
  ]
},{
  "id": 48,
  "typeString": "class",
  "properties": [
    {
  "name": "var tableView_QueueEpisodes: UITableView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var UIView_BottomControlsQueue: UIView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_AmountOfEpisodes: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_ClearAllQueue: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let context",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var queueEpisodesArray: [QueueEpisode]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var currentPlayingEpisodeByPodcast: EpisodesByPodcast? @objc @objc",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "Button_ClearAllQueue(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupNavBar()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupCoreDataPolicy()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupBottomControls()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupTableView()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "closeQueueScreen()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "editQueueEpisode(_ sender: UIBarButtonItem)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "deleteQueueEpisodesToCoreData(indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "loadQueueEpisodesToCoreData()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "saveQueueEpisodesToCoreData(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "clearAllQueueEpisodesInCoreData()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "QueueVC",
  "superClass": 83,
  "extensions": [
    49
  ]
},{
  "id": 50,
  "typeString": "class",
  "properties": [
    {
  "name": "var ImageView_PodcastIcon: UIImageView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var View_PodcastExtraControls: UIView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_PodcastEpisodeName: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_PodcastNowTime: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_PodcastEndTime: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Slider_PodcastScrubber: UISlider!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_ShowPlaybackSpeed: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_ShowAboutEpisode: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_ShowQueue: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_PlayPausePodcast: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_SeekBackPodcast: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_SeekForwardPodcast: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_ShowAirPlayPicker: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_ShowSleepTimer: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let context",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let appSharedDelegate",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var appTintUIColorFromUserDefaults: UIColor?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var avPlayer",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var avPlayerItem",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var playbackRateActual",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var playbackSpeedRate",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var isAVPlayerAudioPaused",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodeByPodcast: EpisodesByPodcast? @objc @objc",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "Slider_PodcastScrubberValueChanged(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_ShowPlaybackSpeed(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_ShowSleepTimer(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_ShowAboutEpisode(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_ShowAirPlayPicker(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_ShowQueue(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_PlayPausePodcast(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_SeekBackPodcast(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_SeekForwardPodcast(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "viewDidLoad()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupAppTintColor()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "checkIfEpisodeExistsInQueueInCoreData()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "checkIfEpisodeHasTimePlayedInQueueInCoreData(episodeToBePlayed: EpisodesByPodcast)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addPlayedEpisodeToQueueToCoreData()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "saveTimePlayedForCurrentEpisode()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupPlayingNowScreen()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupPlayingNowScreenButtons()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupAVPlayer()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupAVAudioSession()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "loadSeekValuesFromUserDefaults() -> (Int, Int)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupRemoteTransportControls()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "updateNowPlayingLockScreenControls()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupPlayingNowScreenWithTimes()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupPlayingNowScreenSlider()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "updatePlayingNowScreen()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showPlaybackSleepTimerOptionMenu()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sleepTimerStopAVPlayer(timeIntervalToSleep: Double)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showPlaybackSpeedVC()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "updatePlaybackSpeedRateAVPlayer()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showPlaybackSleepTimerVC()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showAboutEpisodeVC()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showQueueVC()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "playAVPlayer()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "pauseAVPlayer()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "seekAVPlayer(timeToSeekFromSlider: Float)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "seekAVPlayer(timeToSeek: Double)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "seekBackAVPlayer()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "seekForwardAVPlayer()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "currentAVPlayerDidEnd()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "removeEpisodeFromQueueInCoreData(episodeToDeleteFromPlayingNow: EpisodesByPodcast)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addEpisodeToFinishedInCoreData(episodeToMarkAsFinishedFromPlayingNow: EpisodesByPodcast)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "playNextEpisodeFromQueueInCoreData()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "showAirPlayPicker()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "unwindToPlayingNowVC(_ sender: UIStoryboardSegue)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "PlayingNowVC",
  "superClass": 83
},{
  "id": 51,
  "typeString": "enum",
  "cases": [
    {
  "name": "Grid case Compact case List"
}
  ],
  "name": "SavedPodcastsLayout"
},{
  "id": 52,
  "typeString": "enum",
  "methods": [
    {
  "name": "getSelectedSortByFeedOptionAsString(sortByFeedSelectedOption: SortByFeed) -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "cases": [
    {
  "name": "SortByPodcastName case SortByEpisodeName case SortByNewestToOldest case SortByOldestToNewest"
}
  ],
  "name": "SortByFeed"
},{
  "id": 53,
  "typeString": "enum",
  "methods": [
    {
  "name": "getSelectedSortBySavedPodcastsOptionAsString(sortBySavedPodcastsSelectedOption: SortBySavedPodcasts) -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "cases": [
    {
  "name": "SortByPodcastName case SortByDateAdded"
}
  ],
  "name": "SortBySavedPodcasts"
},{
  "id": 54,
  "typeString": "struct",
  "properties": [
    {
  "name": "var downloadedEpisode_Icon: UIImage!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var downloadedEpisode_PodcastIconURL: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var downloadedEpisode_EpisodeName: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var downloadedEpisode_EpisodeDescription: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var downloadedEpisode_EpsiodeURL: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var downloadedEpisode_EpisodePathLocal: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var downloadedEpisode_EpisodeLength: Int!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var downloadedEpisode_EpisodeTimePlayed: Int!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var downloadedEpisode_EpisodeMarkedAsPlayed: Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var downloadedEpisode_PubDateMS: Int!",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "DownloadedEpisodes"
},{
  "id": 55,
  "typeString": "struct",
  "properties": [
    {
  "name": "var sortBySavedPodcasts: SortBySavedPodcasts?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var sortByFeed: SortByFeed?",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SortBy"
},{
  "id": 56,
  "typeString": "struct",
  "properties": [
    {
  "name": "var episodesByPodcast_Icon: UIImage!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodesByPodcast_PodcastIconURL: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodesByPodcast_PodcastName: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodesByPodcast_EpisodeID: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodesByPodcast_EpisodeName: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodesByPodcast_EpisodeDescription: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodesByPodcast_EpsiodeURL: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodesByPodcast_EpisodePathLocal: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodesByPodcast_EpisodeLength: Int!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var episodesByPodcast_PubDateMS: Int!",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "EpisodesByPodcast"
},{
  "id": 57,
  "typeString": "struct",
  "properties": [
    {
  "name": "var feedNewRelease_Icon: UIImage!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var feedNewRelease_PodcastIconURL: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var feedNewRelease_PodcastID: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var feedNewRelease_PodcastEpisodeID: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var feedNewRelease_PodcastEpisodeName: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var feedNewRelease_PodcastName: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var feedNewRelease_PodcastDescription: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var feedNewRelease_PodcastLength: Int!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var feedNewRelease_PodcastPubMS: Int!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var feedNewRelease_PodcastURL: String!",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "Feed_NewReleases"
},{
  "id": 58,
  "typeString": "struct",
  "properties": [
    {
  "name": "var genreID_ID: Int!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var genreID_Name: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var genreID_ParentID: Int!",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "GenreID"
},{
  "id": 59,
  "typeString": "struct",
  "properties": [
    {
  "name": "var queueEpisode_Icon: UIImage!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var queueEpisode_PodcastIconURL: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var queueEpisode_EpisodeName: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var queueEpisode_EpisodeDescription: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var queueEpisode_EpsiodeURL: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var queueEpisode_EpisodeLength: Int!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var queueEpisode_EpisodeTimePlayed: Int!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var queueEpisode_EpisodeMarkedAsPlayed: Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var queueEpisode_PubDateMS: Int!",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "QueueEpisodes"
},{
  "id": 60,
  "typeString": "struct",
  "properties": [
    {
  "name": "var FeedPodcasts_PodcastID: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var FeedPodcasts_PodcastIconURL: String!",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "Feed_Podcasts"
},{
  "id": 61,
  "typeString": "struct",
  "properties": [
    {
  "name": "var searchPodcast_Icon: UIImage!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var searchPodcast_PodcastIconURL: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var searchPodcast_PodcastID: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var searchPodcast_PodcastName: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var searchPodcast_PodcastDescription: String!",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SearchPodcast"
},{
  "id": 62,
  "typeString": "struct",
  "properties": [
    {
  "name": "var savedPodcast_Icon: UIImage!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcast_PodcastIconURL: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcast_PodcastID: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcast_PodcastName: String!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var savedPodcast_PodcastDescription: String!",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SavedPodcasts"
},{
  "id": 63,
  "typeString": "class",
  "methods": [
    {
  "name": "getPodcastEpisodes(savedPodcast: SavedPodcasts?, completion: @escaping (_ episodesByPodcast: [EpisodesByPodcast])-> Void)",
  "type": "type",
  "accessLevel": "internal"
}
  ],
  "name": "PodcastEpisodes"
},{
  "id": 64,
  "typeString": "class",
  "methods": [
    {
  "name": "getPodcastSearch(searchQuery: String, completion: @escaping (_ searchQueryPodcast: [SearchPodcast])-> Void)",
  "type": "type",
  "accessLevel": "internal"
}
  ],
  "name": "PodcastSearch"
},{
  "id": 65,
  "typeString": "class",
  "methods": [
    {
  "name": "getPodcastTopTenByGenreRegion(completion: @escaping (_ feedNewReleases: [Feed_NewReleases])-> Void)",
  "type": "type",
  "accessLevel": "internal"
}
  ],
  "name": "PodcastTopTenByGenreRegion"
},{
  "id": 66,
  "typeString": "class",
  "methods": [
    {
  "name": "getPodcastFeed(implodedSavedPodcastIDsArray: String, completion: @escaping (_ feedNewReleases: [Feed_NewReleases])-> Void)",
  "type": "type",
  "accessLevel": "internal"
}
  ],
  "name": "PodcastFeed"
},{
  "id": 67,
  "typeString": "class",
  "properties": [
    {
  "name": "let appSharedDelegate",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_EpisodePodcastName: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_EpisodePodcastLength: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_EpisodePodcastPublishedDate: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_PlayPodcast: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var cellDelegate: PodcastCellPlay?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var index: IndexPath?",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "awakeFromNib()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_PlayPodcast(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupTintColorForPlayButton()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "EpisodesByPodcastTableViewCell",
  "superClass": 84
},{
  "id": 68,
  "typeString": "class",
  "properties": [
    {
  "name": "var ImageView_EpisodeIcon: UIImageView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_EpisodeName: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_EpisodeDate: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_EpisodeTimeRemaining: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "awakeFromNib()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "QueueEpisodesTableViewCell",
  "superClass": 84
},{
  "id": 69,
  "typeString": "protocol",
  "methods": [
    {
  "name": "onClickAddPodcast(index: Int)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "PodcastCellSave"
},{
  "id": 70,
  "typeString": "class",
  "properties": [
    {
  "name": "let appSharedDelegate",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_PodcastName: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var ImageView_PodcastIcon: UIImageView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_AddPodcastToSaved: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var cellDelegate: PodcastCellSave?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var index: IndexPath?",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "awakeFromNib()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_AddPodcastToSaved(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupTintColorForPlayButton()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SearchTableViewCell",
  "superClass": 84
},{
  "id": 71,
  "typeString": "class",
  "properties": [
    {
  "name": "var ImageView_PodcastIcon: UIImageView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_PodcastName: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "awakeFromNib()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SavedPodcastsTableViewCell",
  "superClass": 84
},{
  "id": 72,
  "typeString": "protocol",
  "methods": [
    {
  "name": "onClickPlayPodcast(index: Int)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "PodcastCellPlay"
},{
  "id": 73,
  "typeString": "class",
  "properties": [
    {
  "name": "let appSharedDelegate",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var ImageView_PodcastIcon: UIImageView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_EpisodeName: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_PodcastName: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_PodcastLength: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_PlayPodcast: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var cellDelegate: PodcastCellPlay?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var index: IndexPath?",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "awakeFromNib()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_PlayPodcast(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupTintColorForPlayButton()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "FeedTableViewCell",
  "superClass": 84
},{
  "id": 74,
  "typeString": "class",
  "properties": [
    {
  "name": "let appSharedDelegate",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var ImageView_PodcastIcon: UIImageView!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_EpisodeName: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_PodcastName: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Label_PodcastLength: UILabel!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var Button_PlayPodcast: UIButton!",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var cellDelegate: PodcastCellPlay?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var index: IndexPath?",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "awakeFromNib()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "Button_PlayPodcast(_ sender: Any)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setupTintColorForPlayButton()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "DownloadedEpisodesTableViewCell",
  "superClass": 84
},{
  "id": 75,
  "typeString": "class",
  "properties": [
    {
  "name": "var persistentContainer: NSPersistentContainer",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let container",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let error",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "loadAppTintUIColorFromUserDefaults() -> UIColor",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "applicationWillTerminate(_ application: UIApplication)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "saveContext ()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    86
  ],
  "name": "AppDelegate",
  "superClass": 85
},{
  "id": 76,
  "typeString": "class",
  "properties": [
    {
  "name": "var ImageView_PodcastIcon",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "awakeFromNib()",
  "type": "type",
  "accessLevel": "internal"
},
    {
  "name": "init(frame: CGRect)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init?(coder: NSCoder)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SavedPodcastsCollectionViewCell",
  "superClass": 87
},{
  "id": 77,
  "typeString": "class",
  "properties": [
    {
  "name": "var window: UIWindow?",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sceneDidDisconnect(_ scene: UIScene)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sceneDidBecomeActive(_ scene: UIScene)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sceneWillResignActive(_ scene: UIScene)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sceneWillEnterForeground(_ scene: UIScene)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "sceneDidEnterBackground(_ scene: UIScene)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "SceneDelegate",
  "superClass": 85
},{
  "id": 78,
  "typeString": "class",
  "name": "UISlider"
},{
  "id": 79,
  "typeString": "class",
  "name": "UITableViewController"
},{
  "id": 80,
  "typeString": "class",
  "name": "BottomPopupViewController"
},{
  "id": 81,
  "typeString": "class",
  "name": "UICollectionViewController"
},{
  "id": 82,
  "typeString": "class",
  "name": "FormViewController"
},{
  "id": 83,
  "typeString": "class",
  "name": "UIViewController"
},{
  "id": 84,
  "typeString": "class",
  "name": "UITableViewCell"
},{
  "id": 85,
  "typeString": "class",
  "name": "UIResponder"
},{
  "id": 86,
  "typeString": "protocol",
  "name": "UIApplicationDelegate"
},{
  "id": 87,
  "typeString": "class",
  "name": "UICollectionViewCell"
},{
  "id": 88,
  "typeString": "class",
  "name": "UIApplication",
  "extensions": [
    5
  ]
},{
  "id": 89,
  "typeString": "class",
  "name": "Int",
  "extensions": [
    6
  ]
},{
  "id": 90,
  "typeString": "class",
  "name": "Double",
  "extensions": [
    7
  ]
},{
  "id": 91,
  "typeString": "class",
  "name": "String",
  "extensions": [
    9
  ]
},{
  "id": 92,
  "typeString": "class",
  "name": "UserDefaults",
  "extensions": [
    10
  ]
},{
  "id": 93,
  "typeString": "protocol",
  "name": "UISearchBarDelegate"
},{
  "id": 94,
  "typeString": "protocol",
  "name": "UITableViewDataSource"
},{
  "id": 95,
  "typeString": "protocol",
  "name": "UITableViewDelegate"
},{
  "id": 5,
  "typeString": "extension",
  "properties": [
    {
  "name": "var appVersion: String?",
  "type": "type",
  "accessLevel": "internal"
},
    {
  "name": "var appBundleIdentifier: String?",
  "type": "type",
  "accessLevel": "internal"
},
    {
  "name": "var appBundleName: String?",
  "type": "type",
  "accessLevel": "internal"
}
  ]
},{
  "id": 6,
  "typeString": "extension",
  "methods": [
    {
  "name": "formatMSToDate(miliseconds: Int) -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 7,
  "typeString": "extension",
  "methods": [
    {
  "name": "truncate(to places: Int) -> Double",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "stringFromInterval() -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 9,
  "typeString": "extension",
  "properties": [
    {
  "name": "var replacingHTMLEntities: String?",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "safeAddingPercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String?",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 10,
  "typeString": "extension",
  "methods": [
    {
  "name": "colorForKey(key: String) -> UIColor?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "setColor(color: UIColor?, forKey key: String)",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 12,
  "typeString": "extension",
  "methods": [
    {
  "name": "searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    93
  ]
},{
  "id": 13,
  "typeString": "extension",
  "methods": [
    {
  "name": "tableView(_ tableView_SavedPodcasts: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_SavedPodcasts: UITableView, numberOfRowsInSection section: Int) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_SavedPodcasts: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_SavedPodcasts: UITableView, didSelectRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 16,
  "typeString": "extension",
  "methods": [
    {
  "name": "makeContextMenu(indexPath: IndexPath) -> UIMenu",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 17,
  "typeString": "extension",
  "methods": [
    {
  "name": "setupCollectionViewLayout() -> UICollectionViewLayout",
  "type": "instance",
  "accessLevel": "private"
}
  ]
},{
  "id": 18,
  "typeString": "extension",
  "methods": [
    {
  "name": "searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    93
  ]
},{
  "id": 19,
  "typeString": "extension",
  "methods": [
    {
  "name": "collectionView(_ collectionView_SavedPodcasts: UICollectionView, numberOfItemsInSection section: Int) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "collectionView(_ collectionView_SavedPodcasts: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "collectionView(_ collectionView_SavedPodcasts: UICollectionView, didSelectItemAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "collectionView(_ collectionView_SavedPodcasts: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 27,
  "typeString": "extension",
  "methods": [
    {
  "name": "setupSearchInNavBar()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    93
  ]
},{
  "id": 28,
  "typeString": "extension",
  "methods": [
    {
  "name": "onClickAddPodcast(index: Int)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    69
  ]
},{
  "id": 29,
  "typeString": "extension",
  "methods": [
    {
  "name": "searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "runPodcastSearchFromAPI()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_SearchPodcast: UITableView, numberOfRowsInSection section: Int) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_SearchPodcast: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_SearchPodcast: UITableView, didSelectRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 34,
  "typeString": "extension",
  "methods": [
    {
  "name": "setupSearchInNavBar()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    93
  ]
},{
  "id": 35,
  "typeString": "extension",
  "methods": [
    {
  "name": "makeContextMenu(indexPath: IndexPath) -> UIMenu",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 36,
  "typeString": "extension",
  "methods": [
    {
  "name": "onClickPlayPodcast(index: Int)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    72
  ]
},{
  "id": 37,
  "typeString": "extension",
  "methods": [
    {
  "name": "tableView(_ tableView_FeedNewReleases: UITableView, numberOfRowsInSection section: Int) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_FeedNewReleases: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_FeedNewReleases: UITableView, didSelectRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 39,
  "typeString": "extension",
  "methods": [
    {
  "name": "setupSearchInNavBar()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    93
  ]
},{
  "id": 40,
  "typeString": "extension",
  "methods": [
    {
  "name": "onClickPlayPodcast(index: Int)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    72
  ]
},{
  "id": 41,
  "typeString": "extension",
  "methods": [
    {
  "name": "tableView(_ tableView_DownloadedEpisodes: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_DownloadedEpisodes: UITableView, numberOfRowsInSection section: Int) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_SavedPodcasts: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_DownloadedEpisodes: UITableView, didSelectRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 44,
  "typeString": "extension",
  "methods": [
    {
  "name": "setupSearchInNavBar()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    93
  ]
},{
  "id": 45,
  "typeString": "extension",
  "methods": [
    {
  "name": "makeContextMenu(indexPath: IndexPath) -> UIMenu",
  "type": "instance",
  "accessLevel": "internal"
}
  ]
},{
  "id": 46,
  "typeString": "extension",
  "methods": [
    {
  "name": "onClickPlayPodcast(index: Int)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    72
  ]
},{
  "id": 47,
  "typeString": "extension",
  "methods": [
    {
  "name": "tableView(_ tableView_EpsiodesByPodcast: UITableView, numberOfRowsInSection section: Int) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_EpsiodesByPodcast: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_EpsiodesByPodcast: UITableView, didSelectRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_EpsiodesByPodcast: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "prepare(for segue: UIStoryboardSegue, sender: Any?)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    94,
    95
  ]
},{
  "id": 49,
  "typeString": "extension",
  "methods": [
    {
  "name": "tableView(_ tableView_QueueEpisodes: UITableView, numberOfRowsInSection section: Int) -> Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_QueueEpisodes: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_QueueEpisodes: UITableView, canEditRowAt indexPath: IndexPath) -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_QueueEpisodes: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_QueueEpisodes: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "tableView(_ tableView_QueueEpisodes: UITableView, didSelectRowAt indexPath: IndexPath)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    95,
    94
  ]
}] 