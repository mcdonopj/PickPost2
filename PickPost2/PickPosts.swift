//
//  PickPosts.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/24/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import Foundation
import Firebase

class PickPosts {
    var allPickPostsArray = [PickPost]()
    var currentUserPickPostsArray = [PickPost]()
   // let currentUser = authUI.auth?.currentUser
    let currentUserID = Auth.auth().currentUser
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("pickPosts").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("error in PickPost load data: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.allPickPostsArray = []
            //there are querySnapshot!.documents.count docments in the spots snapshot
            for document in querySnapshot!.documents {
                let newPickPost = PickPost(dictionary: document.data())
                newPickPost.documentID = document.documentID
                self.allPickPostsArray.append(newPickPost)
                print("Now here is the all pick posts array: \(self.allPickPostsArray)")
            }
            completed()
        }
        completed()
    }
    
    func getCurrentUserPicks() {
        for pickPost in allPickPostsArray {
            if pickPost.username == "\(currentUserID)" {
                currentUserPickPostsArray.append(pickPost)
            }
        
        }
        print("This is the current user's \(currentUserID) picks: \(currentUserPickPostsArray)")
    }
    
    
    
}

