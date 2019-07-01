//
//  IndexBootstrapView.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 19/06/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation

enum Page: String, CaseIterable {
    case index
    case lorem
    
    func buildPage() -> String {
        switch self {
        case .index: return IndexBootstrapView().make()
        case .lorem: return LoremBootstrapView().make()
        }
    }
}

extension Container {
    init(closure: () -> [BootstrapView]) {
        self.init(children: closure())
    }
}

extension Row {
    init(closure: () -> [BootstrapView]) {
        self.init(children: closure())
    }
}


struct IndexBootstrapView: BootstrapView {
    func make() -> String {
        return BootstrapContainer(title: "Events View", children: [
            NavBar(title: "Events streaming from device", description: "Add events by using <code>Webserver.shared.addEvent()</code>"),
            Container { [
                Row { [
                    Column(size: 1, children: [
                        FlushList(listItems: ["Number of events: \(WebServer.shared.events.count)"]),
                        PagesListBootstrapView(),
                        ]),
                    Column(size: nil, children: [
                        EventsBootstrapView(),
                        ])
                    ]},
                ]},
            ]).make()
    }
    
    struct PagesListBootstrapView: BootstrapView {
        private let pages = Page.allCases
        
        func make() -> String {
            var builtHTML = ""
            
            pages.forEach { page in
                // add a card for each page with a link
                let card = Card(headerText: page.rawValue, title: "Page", text: "Click to open", button: Button(text: "Go", link: Link(destination: page)))
                builtHTML.append("\n\(card.make())\n")
            }
            
            return builtHTML
        }
    }
    
    struct EventsBootstrapView: BootstrapView {
        let events = WebServer.shared.events
        
        func make() -> String {
            return FlushList(listItems: events.map { $0.message }).make()
        }
    }
}

struct LoremBootstrapView: BootstrapView {
    func make() -> String {
        return BootstrapContainer(title: "iOS Debug View", children: [
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
                        )])
                    ]),
                ]),
            ]).make()
    }
}
