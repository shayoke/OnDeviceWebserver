//
//  WebServer.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 17/06/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation
import GCDWebServer


class WebServer {
    func initWebServer() {
        let webServer = GCDWebServer()
        
        webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: { request in
            return GCDWebServerDataResponse(html:
                BootstrapContainer(title: "iOS Debug View", children: [
                    NavBar(title: "iOS Debug View", description: "Connection to device active."),
                    Jumbotron(title: "Connected to device", subtitle: "This is a subtitle"),
                    Container(children: [
                        Row(children: [
                            Column(size: 4, children: [
                                HTMLBootstrapView(html:
                                    """
        <h3>Column 1</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
        <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
""")
                                ]),
                            Column(size: 4, children: [
                                HTMLBootstrapView(html:   """
        <h3>Column 2</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
        <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
"""
                                )]),
                            Column(size: 4, children: [
                                HTMLBootstrapView(html: """
        <h3>Column 3</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
        <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
"""
                                ) ])
                            ]),
                        ]),
                    ]).make()
            )
        })
        
        webServer.start(withPort: 8080, bonjourName: "GCD Web Server")
        
        print("Visit \(webServer.serverURL!) in your web browser")
    }
    
    
}

