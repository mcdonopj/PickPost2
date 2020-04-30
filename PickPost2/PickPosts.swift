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
    
    
    
    func getData(completed: @escaping()->()) {
        print("🥁🥁🥁🥁🥁🥁🥁🥁 In the get Data function!")
        let urlString = "https://api.the-odds-api.com/v3/odds/?sport=UPCOMING&region=eu&mkt=h2h&apiKey=21f3240fa00bcfe0a554de3b68c74020"
               print("we are accessing url string \(urlString)")
             print("we are accessing url string \(urlString)")
          
             //Create a URL
             guard let url = URL(string: urlString) else {
                 print("Error could not create a url from \(urlString)")
              completed()
                 return
             }
             
             // create session
             let session = URLSession.shared
             
             //get data with .dataTask method
             let task = session.dataTask(with: url) { (data, response, error) in
                 if let error = error {
                     print("Error! \(error.localizedDescription)")
                }
                 
                 //deal with data
                 do {
                    let returned = try JSONDecoder().decode(Line.self, from: data!)
                    let returnedDetails = returned.teams
                    print("😇😇😇😇😇😇 Here are returnedTEams, \(returnedDetails)")
        //Lines.lineArray.append(returned)
                    print("here is what your returned, returned \(returned)")
                  //print("Here is what the line array you returned \(Lines.lineArray)")
                    print("Here is details of what your returned now teams: \(returned.teams)")
                    print("Here is details of what your returned now sportNice: \(returned.sport_nice)")
                    //print("Here is details of what your returned now teams: \(returned.h2h)")
                    //   print("Here is details of what your returned now away team odds: \(returned.h2h[0])")
                //print("Here is details of what your returned now home team odds: \(returned.h2h[1])")
                    print("Here is details of what your returned now commenceTime: \(returned.commence_time)")
                 } catch {
                     print("PickPosts.get Data JSON ERROR \(error.localizedDescription)")
                 }
            completed()
             }
              task.resume()
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
                print(document)
                let newPickPost = PickPost(dictionary: document.data())
                newPickPost.documentID = document.documentID
                self.allPickPostsArray.append(newPickPost)
                print("Loaded: \(newPickPost.toString())")
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

