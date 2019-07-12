//
//  ViewController.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 17/06/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebServer.startServer()
        
        ipLabel.text = "Server started. \nAddress:\n\(WebServer.shared.ipAddress!)"

        print("Server started. \nAddress:\n\(WebServer.shared.ipAddress!)")
        
        AnalyticsDebugger.shared.log("This is a test", platform: "Platform 1")
        AnalyticsDebugger.shared.log("This is a 2", platform: "Platform 2")
        AnalyticsDebugger.shared.log("This is a 3", platform: "Platform 1")
        AnalyticsDebugger.shared.log("This is a 4", platform: "Platform 2")
        AnalyticsDebugger.shared.log("This is a 5", platform: "Platform 3")
        AnalyticsDebugger.shared.log("This is a 6", platform: "Platform 2")
        AnalyticsDebugger.shared.log("This is a 6", platform: "Platform 3")



        NetworkManager.shared.fetchPosts { _ in

        }
    }
}

