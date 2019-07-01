//
//  CommonComponents.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 01/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import UIKit

struct DefaultNavBar: BootstrapView {
    func make() -> String {
        let device = UIDevice.current
        let name = device.name
        let version = "\(device.systemName) \(device.systemVersion)"

        return NavBar(title: "iOS Debug View", description: """
            Connected to \(name), \(version).
            Add events by using <code>Webserver.shared.addEvent()</code>
            """
            ).make()
    }
}
