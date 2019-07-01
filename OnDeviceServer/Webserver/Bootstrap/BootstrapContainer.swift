//
//  BootstrapContainer.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 19/06/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation

protocol BootstrapView {
    func make() -> String
}

extension BootstrapView {
    func generateString(from children: [BootstrapView]) -> String {
        return children.reduce("") { "\($0)\n\($1.make())" }
    }
}

struct BootstrapContainer: BootstrapView {
    let title: String
    let children: [BootstrapView]
    
    func make() -> String {
        return """
        <!DOCTYPE html>
        <html lang="en">
        <head>
        <title>\(title)</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        </head>
        <body>
        \(generateString(from: children))
        </body>
        </html>
        """
    }
}
