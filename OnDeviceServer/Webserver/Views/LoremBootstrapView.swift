//
//  LoremBootstrapView.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 01/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation

struct LoremBootstrapView: BootstrapView {
    func make() -> String {
        return BootstrapContainer(title: "iOS Debug View", children: [
            DefaultNavBar(),
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
