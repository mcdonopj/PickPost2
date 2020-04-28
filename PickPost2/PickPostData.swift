//
//  PickPostData.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/24/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import Foundation

struct PickPostData: Codable { //Codable {
    var text: String
    var commenceTime: TimeInterval
    var timePosted: TimeInterval
    var username: String
    var upVotes: Int
    var downVotes: Int
    var comments: [String] = []
    var chosenTeam: String
    var teams: [String] = []
    var odds: Double
    var sport: String
    var amountWagered: Int
    var amountToWin: Double
    var documentID: String
  //  var userPhoto: UIImage
   // var record: String
  //  var balance: Decimal
  //  var winner: Bool
}
