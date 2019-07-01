//
//  IndexBootstrapView.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 19/06/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation

struct IndexBootstrapView: BootstrapView {
    func make() -> String {
        return BootstrapContainer(title: "Events View", children: [
            DefaultNavBar(),
            Jumbotron(title: "Connected to device", subtitle: "This is a subtitle"),
            Container { [
                Row {[HTMLBootstrapView(html: "<h3>Pages</h3>")]},
                Row {[PagesListBootstrapView()]},
                ]},
            ]).make()
    }
}

struct PagesListBootstrapView: BootstrapView {
    private let pages = Page.allCases
    
    func make() -> String {
        // Transform a page into a list of columns
        let cardColumns = pages.map { Column(size: 4, children: [PageCard(page: $0)]) }
        return Row(children: cardColumns).make()
    }
}

struct PageCard: BootstrapView {
    let page: Page
    
    func make() -> String {
        return Card(
            headerText: "/\(page.rawValue)",
            title: "<h4>\(page.rawValue.capitalized)</h4>",
            text: "Click to open",
            button: Button(text: "Go",
                           link: Link(destination: page))).make()
    }
}

struct EventsBootstrapView: BootstrapView {
    let events = WebServer.shared.events
    
    func make() -> String {
        return FlushList(listItems: events.map { $0.message }).make()
    }
}
