//
//  TextPosts.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/24/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import Foundation
import Firebase
import FirebaseUI

class TextPosts {

    var db: Firestore!
    var currentUserTextPosts: [TextPostData] = []
     var allTextPosts: [TextPostData] = []
    
    init() {
        db = Firestore.firestore()
    }
    

    func loadData(completed: @escaping () -> ()) {
         db.collection("textPosts").addSnapshotListener { (querySnapshot, error) in
             guard error == nil else {
                 print("error: adding the snapshot listener \(error!.localizedDescription)")
                 return completed()
             }
             self.allTextPosts = []
             //there are querySnapshot!.documents.count docments in the spots snapshot
             for document in querySnapshot!.documents{
                print("document = \(document)")
                print("querySnapshot!.documents \(querySnapshot!.documents)")
                let newTextPost = TextPost(dictionary: document.data())
               // let newTextPost.textPost = TextPost
            //    let newTextPost = TextPost(text: document.username , time: document.time, postingUserID: document.postingUserID, upVotes: document.upVotes, downVotes: document.downVotes, comments: document.comments, documentID: document.documentID)
             newTextPost.documentID = document.documentID
           //     self.allTextPosts.append(newTextPost.textPost!) //I took out ! at end? maybe put back
             //   self.allTextPosts.append(newTextPost)
             }
             completed()
         }
        // completed()
     }
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func loadData(completed: @escaping () -> ()) {
//        db.collection("textPosts").addSnapshotListener { (querySnapshot, error) in
//            guard error == nil else {
//                print("error in TextPost add listener: adding the snapshot listener \(error!.localizedDescription)")
//                return completed()
//            }
//            self.allTextPosts = []
//            //there are querySnapshot!.documents.count docments in the spots snapshot
//            for snap in querySnapshot!.documents {
//              //  let newTextPost = TextPost(textPost: document.data)
//               // let newTextPost = TextPost(textPost: TextPostData()
//                print("I need to define newTextPost so I can successfully get data???❤️❤️❤️❤️")
//          // let newTextPost = TextPost(textPost: TextPostData(text: String, time: <#T##Date#>, username: <#T##String#>, upVotes: <#T##Int#>, downVotes: <#T##Int#>, comments: <#T##[String]#>))
//          //  newTextPost.documentID = document.documentID
//         //   self.allTextPosts.append(newTextPost)
//            }
//
//            completed()
//        }
//       // completed()
//    }
    
    
    
    
    
    
    
}

