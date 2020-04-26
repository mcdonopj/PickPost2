//
//  Line.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/24/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import Foundation

struct Line: Codable {
    let h2h: [String] = []
    //gonna have to convert to decimalss
    let sportNice: String
    var teams: [String] = []
    let commenceTime: String // gonna have to convert to time
    var sites: [String] = []
    let siteKey: String
    let siteNice: String
    let lastUpdate: String // gonna have to convert to time
}
