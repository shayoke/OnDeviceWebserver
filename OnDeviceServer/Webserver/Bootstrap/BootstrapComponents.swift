//
//  BootstrapComponents.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 19/06/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation

struct HTMLBootstrapView: BootstrapView {
    let html: String
    
    func make() -> String {
        return html
    }
}

struct Column: BootstrapView {
    let size: Int?
    let children: [BootstrapView]
    
    private let classTagPrefix = "col-sm"
    private var classTag: String {
        if let columnSize = size {
            return "\(classTagPrefix)-\(String(columnSize))"
        }
        
        return classTagPrefix
    }
    
    func make() -> String {
        return """
        <div class="\(classTagPrefix)">
        \(generateString(from: children))
        </div>
        """
    }
}

struct CardColumns: BootstrapView {
    let children: [BootstrapView]
    
    func make() -> String {
        return """
        <div class="card-columns">
        \(generateString(from: children))
        </div>
        """
    }
}

struct Jumbotron: BootstrapView {
    let title: String
    let subtitle: String
    func make() -> String {
        return """
        <div class="jumbotron text-center">
        <h1>\(title)</h1>
        <p>\(subtitle)</p>
        </div>
        
        """
    }
}

struct Container: BootstrapView {
    let children: [BootstrapView]
    func make() -> String {
        return """
        <div class="container" style="padding: 2rem;">
        \(generateString(from: children))
        </div>
        """
    }
}

struct Row: BootstrapView {
    let children: [BootstrapView]
    
    func make() -> String {
        return """
        <div class="row">
        \(generateString(from: children))
        </div>
        """
    }
}


struct NavBar: BootstrapView {
    let title: String
    let description: String
    
    func make() -> String {
        return """
        <div class="pos-f-t">
        <div class="collapse" id="navbarToggleExternalContent">
        <div class="bg-dark p-4">
        <h5 class="text-white h4">\(title)</h5>
        <span class="text-muted">\(description)</span>
        </div>
        </div>
        <nav class="navbar navbar-dark bg-dark">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
        </button>
        </nav>
        </div>
        """
    }
}

struct FlushList: BootstrapView {
    let listItems: [String]
    
    private func generateListItemHTML() -> String {
        return listItems.reduce("") { "\($0)\n<li class=\"list-group-item\">\($1)</li>" }
    }
    
    func make() -> String {
        return """
        <ul class="list-group list-group-flush">
        \(generateListItemHTML())
        </ul>
        """
    }
}

struct Card: BootstrapView {
    let headerText: String?
    let title: String
    let text: String
    let button: Button?
    let footerText: String?
    
    private func generateHeaderTextHtml() -> String {
        guard let headerText = headerText else {
            return ""
        }
        
        return """
        <div class="card-header">\(headerText)</div>
        """
    }
    
    private func generateFooterTextHtml() -> String {
        guard let footerText = footerText else {
            return ""
        }
        
        return """
        <div class="card-footer">
        <small class="text-muted">\(footerText)</small>
        </div>
        """
    }
    
    func make() -> String {
        return """
        <div class="card" style="width: 22rem;">
        \(generateHeaderTextHtml())
        <div class="card-body">
        <h5 class="card-title">\(title)</h5>
        <p class="card-text">\(text)</p>
        \(button?.make() ?? "")
        </div>
        \(generateFooterTextHtml())
        </div>
        """
    }
}

struct PageLink: BootstrapView {
    let destination: Page
    
    func make() -> String {
        return "/\(destination.rawValue)"
    }
}

struct LinkHTML: BootstrapView {
    let string: String
    
    func make() -> String {
        return string
    }
}

struct Button: BootstrapView {
    let text: String
    let link: PageLink
    
    func make() -> String {
        return """
        <a href="\(link.make())" class="btn btn-primary">\(text)</a>
        """
    }
}

struct CardDeck: BootstrapView {
    let cards: [BootstrapView]
    
    func make() -> String {
        return """
        <div class="card-deck">
        \(generateString(from: cards))
        </div>
        """
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

