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
    var commenceTime: Date
    var timePosted: Date
    var username: String
    var upVotes: Int
    var downVotes: Int
    var comments: [String] = []
    var chosenTeam: String
    var odds: String
    var amountWagered: Decimal
    var amountToWin: Decimal
    var documentID: String
  //  var userPhoto: UIImage
   // var record: String
  //  var balance: Decimal
  //  var winner: Bool
}
