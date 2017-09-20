//
//  ViewController.swift
//  ios-swift-demo
//
//  Created by Daniel Capacio on 2017-09-15.
//  Copyright © 2017 Daniel Capacio. All rights reserved.
//

import UIKit
import TraceLog
import FirebasePerformance
import FirebaseRemoteConfig
import UIColor_Hex_Swift

class ViewController: UIViewController
{
    private let remoteConfig = RemoteConfig.remoteConfig()
    let remoteConfigFetcher = RemoteConfigFetcher(plist: "RemoteConfig")

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logTrace { "enter viewDidLoad" }

        let trace = Performance.startTrace(name: "test trace")!
        trace.incrementCounter(named: "viewDidLoad")
        trace.stop()

        let remoteConfigSettings = RemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSettings!
        remoteConfig.setDefaults(fromPlist: "RemoteConfig")

        remoteConfigFetcher.fetchConfig
        {
            _ in
            logTrace { "enter completionHandler" }
            let colourValue = self.remoteConfig[RemoteConfigKeys.color.rawValue]
            let colourString = colourValue.stringValue!
            let colour = UIColor(colourString)

            self.view.backgroundColor = colour
            logTrace { "exit completionHandler" }
        }

        logTrace { "exit viewDidLoad" }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        logTrace { "enter didReceiveMemoryWarning" }
        logTrace { "exit didReceiveMemoryWarning" }
    }

    // MARK: -RemoteConfigFetcherDelegate
    func remoteConfigFetcher(_: RemoteConfig, didFailWithError error: Error)
    {
        logTrace { "enter onError" }
        print("Error \(error.localizedDescription)")
        logTrace { "exit onError" }
    }
}
