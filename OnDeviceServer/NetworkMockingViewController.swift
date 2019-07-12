//
//  NetworkMockingViewController.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 12/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import UIKit

class NetworkMockingViewController: UIViewController {
    let liveBaseURL = "https://jsonplaceholder.typicode.com/"
    public var mockBaseURL: String?

    let path = "/posts"
}

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

