//
//  NetworkPathManager.swift
//  Podcasted
//
//  Created by Ali Moussa on 07/11/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import Foundation
import Network

class NetworkPathManager {
    
    static let networkPathMonitor = NWPathMonitor()
    
    class func startNWPathMonitorWithQueue() {
        let networkPathMonitorQueue = DispatchQueue.global(qos: .background)
        self.networkPathMonitor.start(queue: networkPathMonitorQueue)
    }
    
}
