//
//  GMReachability.swift
//  Gimme
//
//  Created by hule on 2024/5/24.
//

import UIKit
import Reachability

public enum ReachabilityStatus {
   case notReachable
   case unknown
   case ethernetOrWiFi
   case wwan
}

public class MCReachabilityManager: NSObject {

    public static let shared = MCReachabilityManager()
    fileprivate var reachability: Reachability?

    public typealias NetworkReachable = (ReachabilityStatus) -> Void
    public typealias NetworkUnreachable = (ReachabilityStatus) -> Void

    public var whenReachable: NetworkReachable? // 网络连接回调(实时)
    public var whenUnreachable: NetworkUnreachable? // 网络断开回调(实时)

    private  override init() {
        super.init()
    }

    /// 是否联网 (这一刻)
    public var isReachable: Bool {
        get {
            guard let reachability = try? Reachability() else { return false }
            if reachability.connection == .wifi || reachability.connection == .cellular {
                return true
            }
            return false
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 网络监听
    public func startListening() {
        guard let reachability = try? Reachability() else { return }
        self.reachability = reachability
        NotificationCenter.default.addObserver(self, selector: #selector(MCReachabilityManager.reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {

        }
    }

   @objc func reachabilityChanged(_ note: Notification) {

       guard let reachability = note.object as? Reachability else { return }

       switch reachability.connection {
       case .wifi:
           whenReachable?(.ethernetOrWiFi)
       case .cellular:
           whenReachable?(.wwan)
       case .none:
           whenUnreachable?(.unknown)
       case .unavailable:
           whenUnreachable?(.unknown)
       }
   }

    deinit {
        self.reachability?.stopNotifier()
    }
}
