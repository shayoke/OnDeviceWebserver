//
//  Pages.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 01/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation

/// Creates a route at "<URL>/name"
/// Note that the first item in the list will be the default page
enum Page: String, CaseIterable {
    case index
    case lorem
    case deviceInfo
    case analytics
    
    private func buildPage(with queries: [String: String]?) -> String {
        switch self {
        case .index: return IndexBootstrapView().make()
        case .lorem: return LoremBootstrapView().make()
        case .deviceInfo: return DeviceInfoBootstrapView().make()
        case .analytics: return AnalyticsBootstrapView(queries: queries).make()
        }
    }
    
    static func html(for path: String, queries: [String: String]?) -> String? {
        let firstMatchingPage = allCases.filter { "/\($0.rawValue)" == path }.first
        return firstMatchingPage?.buildPage(with: queries)
    }
    
    static var indexURL: URL {
        return URL(string: index.rawValue)!
    }
}

extension Page {
    var description: String {
        switch self {
        case .index: return "Homepage"
        case .lorem: return "Simple Lorem Ipsum page."
        case .deviceInfo: return "Contains info about the connected iOS device."
        case .analytics: return "Analytics events sent by the device."
        }
    }
}
