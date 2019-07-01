//
//  ViewController.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 17/06/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebServer.startServer()
        WebServer.addEvent(Event(message: "Web server started successfully"))
        WebServer.addEvent(Event(message: "Web server started successfully"))
        WebServer.addEvent(Event(message: "Web server started successfully"))
        WebServer.addEvent(Event(message: "Web server started successfully"))
        WebServer.addEvent(Event(message: "Web server started successfully"))
        WebServer.addEvent(Event(message: "Web server started successfully"))
        WebServer.addEvent(Event(message: "Web server started successfully"))
        WebServer.addEvent(Event(message: "Web server started successfully"))
        WebServer.addEvent(Event(message: "Web server started successfully"))
    }
}

