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
    var ipAddress: String?
    
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
    
    public static func stub(_ path: String, with text: String) {
        shared.interceptors[path] = text
    }
    
    private var interceptors = [String: String]()
    
    private func start() {
        WebServer.loggingLevel = 4

        webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self) { request in
            let path = request.path

            for (matchedPath, text) in self.interceptors where path.contains(matchedPath) {
                return GCDWebServerDataResponse(text: text)
            }
            
            guard let html = Page.html(for: path, queries: request.query) else {
                return GCDWebServerResponse(redirect: Page.indexURL, permanent: true)
            }

            return GCDWebServerDataResponse(html: html)
        }

        webServer.start(withPort: port, bonjourName: "GCD Web Server")
        ipAddress = webServer.serverURL?.absoluteString ?? ""
    }
    
    static func addEvent(_ event: Event) {
        shared.events.append(event)
    }
}

struct Event {
    var message: String
}
