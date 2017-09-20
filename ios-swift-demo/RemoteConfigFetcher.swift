//
//  RemoteConfigFetcher.swift
//  ios-swift-demo
//
//  Created by Daniel Capacio on 2017-09-19.
//  Copyright © 2017 Daniel Capacio. All rights reserved.
//

import Foundation
import TraceLog
import FirebaseRemoteConfig

class RemoteConfigFetcher
{
    private let remoteConfig = RemoteConfig.remoteConfig()
    var delegate: RemoteConfigFetcherDelegate?

    init(plist: String)
    {
        let remoteConfigSettings = RemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSettings!
        remoteConfig.setDefaults(fromPlist: plist)
    }

    func fetchConfig(_ competionHander: @escaping (() -> Void))
    {
        logTrace { "enter fetchConfig" }
        var expirationDuration = 3600

        if remoteConfig.configSettings.isDeveloperModeEnabled
        {
            expirationDuration = 0
        }

        remoteConfig.fetch(withExpirationDuration: TimeInterval(expirationDuration))
        {
            (status, error) -> Void in

            logTrace { "enter fetch completionHandler" }

            if status == .success
            {
                self.remoteConfig.activateFetched()
            }
            else if let error = error
            {
                self.delegate?.remoteConfigFetcher(self.remoteConfig, didFailWithError: error)
            }

            competionHander()
            logTrace { "exit fetch completionHandler" }
        }
        logTrace { "exit fetchConfig" }
    }
}
