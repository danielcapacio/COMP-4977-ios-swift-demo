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

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logTrace { "enter viewDidLoad" }
        let trace = Performance.startTrace(name: "test trace")!
        trace.incrementCounter(named: "viewDidLoad")
        trace.stop()
        logTrace { "exit viewDidLoad" }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        logTrace { "enter didReceiveMemoryWarning" }
        logTrace { "exit didReceiveMemoryWarning" }
    }
}
