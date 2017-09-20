//
//  RemoteConfigFetcherDelegate.swift
//  ios-swift-demo
//
//  Created by Daniel Capacio on 2017-09-19.
//  Copyright © 2017 Daniel Capacio. All rights reserved.
//

import Foundation
import TraceLog
import FirebaseRemoteConfig

protocol RemoteConfigFetcherDelegate
{
    func remoteConfigFetcher(_ remoteConfig: RemoteConfig, didFailWithError error: Error)
}
