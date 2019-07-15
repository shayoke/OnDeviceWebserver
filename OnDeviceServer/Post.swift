//
//  Post.swift
//  OnDeviceServer
//
//  Created by Shayoke Mukherjee on 15/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import Foundation

public struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

