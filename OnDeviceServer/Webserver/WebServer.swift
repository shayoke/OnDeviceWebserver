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
    static var shared = WebServer()
    private(set) var events: [Event] = []
    private let webServer = GCDWebServer()
    
    private init() {}
    
    let port: UInt = 8080
    
    static var loggingLevel: Int32 = 0 {
        didSet {
            GCDWebServer.setLogLevel(loggingLevel)
        }
    }
    
    static func startServer() {
        shared.start()
    }
    
    private func start() {
        WebServer.loggingLevel = 4

        webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: { request in
            let path = request.path
            let pages: [Page] =  Page.allCases
            let resolvedPath = pages.filter { "/\($0.rawValue)" == path }.first
            
            guard let firstPage = pages.first?.rawValue else {
                return GCDWebServerResponse()
            }

            guard let html = resolvedPath?.buildPage() else {
                return GCDWebServerResponse(redirect: URL(string: firstPage)!, permanent: true)
            }
            
            return GCDWebServerDataResponse(html: html)
        })

        webServer.start(withPort: port, bonjourName: "GCD Web Server")
        print("Visit \(webServer.serverURL!) in your web browser")
    }
    
    static func addEvent(_ event: Event) {
        shared.events.append(event)
    }
}

struct Event {
    var message: String
}
