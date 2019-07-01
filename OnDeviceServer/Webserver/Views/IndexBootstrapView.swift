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
                Row(children: [
                    Column(size: 4, children: [
                        Row {[HTMLBootstrapView(html: "<h3>Pages</h3>")]},
                        Row {[PagesListBootstrapView()]},
                        ]),
                    ]),
                ]},
            ]).make()
    }
}

struct PagesListBootstrapView: BootstrapView {
    private let pages = Page.allCases
    
    func make() -> String {
        return CardDeck(cards: pages.map { PageCard(page: $0) }).make()
    }
}

struct PageCard: BootstrapView {
    let page: Page
    
    func make() -> String {
        return Card (
            headerText: "/\(page.rawValue)",
            title: "<h4>\(page.rawValue.capitalized)</h4>",
            text: page.description,
            button: Button(text: "Open",
                           link: PageLink(destination: page)),
            footerText: nil
            ).make()
    }
}

struct EventsBootstrapView: BootstrapView {
    let events = WebServer.shared.events
    
    func make() -> String {
        return FlushList(listItems: events.map { $0.message }).make()
    }
}
