//
//  TextPost.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/24/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import Foundation
import Firebase
import FirebaseUI

class TextPost {
    var text: String
    var time: TimeInterval
    var postingUserID: String
    var upVotes: Int
    var downVotes: Int
    var comments: [String]
    var textPost: TextPostData?
    var documentID: String

//       init(textPost: TextPost) {
//
//        self.textPost = TextPostData(text: "fake text", time: Date(), username: "fake username", upVotes: 0, downVotes: 0, comments: [])
//       }

    var dictionary: [String: Any] {
        return ["text": text, "time": time, "postingUserID": postingUserID, "upVotes": upVotes, "downVotes": downVotes, "comments": comments, "documentID": documentID]
    }

    init(text: String, time: TimeInterval, postingUserID: String, upVotes: Int, downVotes: Int, comments: [String], documentID: String) {
        self.text = text
        self.time = time
        self.postingUserID = postingUserID
        self.upVotes = upVotes
        self.downVotes = downVotes
        self.comments = comments
        self.documentID = documentID
    }
    
    convenience init(dictionary: [String: Any]) {
        let text = dictionary["text"] as! String? ?? ""
        let time = dictionary["time"] as! TimeInterval? ?? TimeInterval()
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        let upVotes = dictionary["upVotes"] as! Int? ?? 0
        let downVotes = dictionary["downVotes"] as! Int? ?? 0
         let comments = dictionary["comments"] as! [String]? ?? []
         let documentID = dictionary["documentID"] as! String? ?? ""
        self.init(text: text, time: time, postingUserID: postingUserID, upVotes: upVotes, downVotes: downVotes, comments: comments, documentID: "")
        
    }
    
    
    func saveData(completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        //grab the userID
        guard let postingUserID1 = (Auth.auth().currentUser?.uid) else {
            print("Error: could not save data because we don't have a valid postingUserID")
            return completed(false)
        }
        self.postingUserID = postingUserID1
        //create the dictionary represnting the data we want to save
        let dataToSave = self.dictionary
        print("This is self.docuementID \(self.documentID)")
        //if we HAVE saved a record, we''ll have a document ID
        if self.documentID != "" {
            let ref = db.collection("textPosts").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("Error: creating new document \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("new document created with ref ID \(ref.documentID ?? "unknown")")
                    completed(true)
                }
            }
        } else {
            var ref: DocumentReference? = nil // let firestore create the new document ID
            ref = db.collection("textPosts").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("Error creating new document.")
                    completed(false)
                } else {
                    print("new document created with ref ID \(ref?.documentID ?? "unkown")")
                    completed(true)
                }
                
                
            }
        }
        
        
        completed(true)
        
        
        
    }
    
    
}
