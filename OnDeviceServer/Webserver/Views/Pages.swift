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
    
    func buildPage() -> String {
        switch self {
        case .index: return IndexBootstrapView().make()
        case .lorem: return LoremBootstrapView().make()
        case .deviceInfo: return DeviceInfoBootstrapView().make()
        }
    }
}

