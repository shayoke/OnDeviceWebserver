//
//  DeviceInfoBootstrapView.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 01/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation
import UIKit

struct DeviceInfoBootstrapView: BootstrapView {
    func make() -> String {

        let device = UIDevice.current
        let name = device.name
        let version = "\(device.systemName) \(device.systemVersion)"
        
        return BootstrapContainer(title: "Device Info", children: [
            DefaultNavBar(),
            Container {
                [
                    Column(size: 3, children: [
                        FlushList(listItems: [
                            "Device Name: \(name)",
                            "\(version)"
                            ]),
                        ])
                ]
            }
            ]).make()
    }
}


