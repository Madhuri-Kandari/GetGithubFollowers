//
//  NetworkStatus.swift
//  GithubDemo
//
//  Created by M1066749 on 08/07/21.
//

import Foundation
import Network

public enum ConnectionType{
    case wifi
    case ethernet
    case cellular
    case unknown
}

class NetworkStatus {
    static public let shared = NetworkStatus()
    private var monitor:NWPathMonitor
    private var queue = DispatchQueue.global()
    var isOn:Bool = true
    var connType:ConnectionType = .wifi
    
    private init(){
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
    
    func start(){
        self.monitor.pathUpdateHandler = { path in
            self.isOn = path.status == .satisfied
            self.connType = self.chechConnectionTypeForPath(path)
        }
    }
    
    func stop(){
        self.monitor.cancel()
    }
    
    func chechConnectionTypeForPath(_ path:NWPath) -> ConnectionType{
        if path.usesInterfaceType(.wifi){
            return .wifi
        } else if path.usesInterfaceType(.wiredEthernet){
            return .ethernet
        }else if path.usesInterfaceType(.cellular){
            return .cellular
        }
        return .unknown
    }
}
