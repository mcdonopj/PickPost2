//
//  TextPost.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/24/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import Foundation

class TextPost {
    var textPost: TextPostData?
       init(textPost: TextPost) {
        self.textPost = TextPostData(text: "fake text", time: Date(), username: "fake username", upVotes: 0, downVotes: 0, comments: [])
       }

}
