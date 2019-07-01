//
//  AnalyticsBootstrapView.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 01/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation

struct AnalyticsBootstrapView: BootstrapView {
    let queries: [String: String]?
    
    func platformQuery() -> String? {
        guard let allQueries = queries else { return nil }
        
        if allQueries.keys.contains("platform") {
            return allQueries["platform"]
        }
        
        return nil
    }
    
    func make() -> String {
        return BootstrapContainer(title: "Analytics View", children: [
            DefaultNavBar(),
            Container(children: [
                HTMLBootstrapView(html: "<h3>Available Platforms:</h3>"),
                generateListOfAllPlatforms(),
                generateAlerts(),
                ]),
            ]).make()
    }
    
    private func generateListOfAllPlatforms() -> BootstrapView {
        let items = AnalyticsDebugger.shared.fetchAllPlatforms().sorted()
        
        var buttons = items.map { platform -> ButtonWithBadge in
            return ButtonWithBadge(title: platform, badgeCounter: 2, link: LinkHTML(string: "?platform=\(platform)"))
        }

        buttons.insert(ButtonWithBadge(title: "Remove Filter", badgeCounter: 2, link: LinkHTML(string: "?")), at: 0)
        return Row(children: buttons)
    }
    
    let alertCardDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    private func generateAlerts() -> BootstrapView {
        var logs = [LogItem]()
        
        if let platform = platformQuery() {
            logs.append(contentsOf: AnalyticsDebugger.shared.fetchLogs(forPlatform: platform))
        } else {
            logs.append(contentsOf: AnalyticsDebugger.shared.logs)
        }
       
        logs = logs.sorted { $0.timestamp > $1.timestamp }
        
        let cards = logs.map { logItem -> Card in
            let formattedDate = alertCardDateFormatter.string(from: logItem.timestamp)
            return Card(headerText: logItem.platform, title: logItem.message, text: "", button: nil, footerText: formattedDate)
        }

        return CardColumns(children: cards)
    }
}

struct ButtonWithBadge: BootstrapView {
    let title: String
    let badgeCounter: Int
    let link: LinkHTML?
    
    func make() -> String {
        return """
        <a role="button" class="btn btn-primary" href="\(link?.make() ?? "")" style="padding: 1rem;margin: 1rem;">
        \(title)     <span class="badge badge-light">\(String(badgeCounter))</span>
        </a>
        """
    }
}

struct LogItem {
    let timestamp = Date()
    let message: String
    let platform: String
}

class AnalyticsDebugger {
    static var shared = AnalyticsDebugger()
    var logs = [LogItem]()

    private init(){}
    
    func log(_ message: String, platform: String) {
        logs.append(LogItem(message: message, platform: platform))
    }
    
    func fetchLogs(forPlatform platform: String) -> [LogItem] {
        return logs.filter { $0.platform == platform }
    }
    
    func fetchAllPlatforms() -> [String] {
        return Array(Set<String>(logs.map { $0.platform }))
    }
}
