//
//  PickPost.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/24/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import Foundation
import Firebase


class PickPost {
    var pickPost: PickPostData?
    
    var text: String
    var commence_time: TimeInterval
    var timePosted: TimeInterval
    var username: String
    var upVotes: Int
    var downVotes: Int
    var comments: [String] = []
    var chosenTeam: String
    var teams: [String] = []
    var odds: Double
    var sport: String
    var amountWagered: Double
    var amountToWin: Double
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["text": text, "commenceTime": commence_time, "timePosted": timePosted, "username": username, "Upvotes": upVotes, "downVotes": downVotes, "chosenTeam": chosenTeam, "teams": teams, "odds": odds, "sport": sport, "amountWagered": amountWagered, "amountToWin": amountToWin, "documentID": documentID]
    }
    
//
//       init(pickPost: PickPost) {
//        self.pickPost = PickPostData(text: "Away Team at Home Team - Chosen Team -XXX", commenceTime: Date(), timePosted: Date(), username: "Username 3", upVotes: 0, downVotes: 0, comments: [], chosenTeam: "Picked this team", odds: "->at these odds", amountWagered: 888, amountToWin: 777, documentID: "Fake Document ID")
//       }
//
    
        
        
    init(text: String, commenceTime: TimeInterval, timePosted: TimeInterval, username: String, upVotes: Int, downVotes: Int, comments: [String], chosenTeam: String, teams: [String], odds: Double, sport: String, amountWagered: Double, amountToWin: Double, documentID: String) {
               self.text = text
               self.commence_time = commenceTime
               self.timePosted = timePosted
               self.username = username
               self.upVotes = upVotes
            self.downVotes = downVotes
            self.comments = comments
            self.chosenTeam = chosenTeam
        self.teams = teams
            self.odds = odds
        self.sport = sport
            self.amountWagered = amountWagered
            self.amountToWin = amountToWin
            self.documentID = documentID

               
           }
           
           
           convenience init(dictionary: [String: Any]) {
               let text = dictionary["text"] as! String? ?? ""
            let commenceTime = dictionary["commenceTime"] as! TimeInterval? ?? TimeInterval() //
               let timePosted = dictionary["timePosted"] as! TimeInterval? ?? TimeInterval()
               let username = dictionary["username"] as! String
               let upVotes = dictionary["upVotes"] as! Int? ?? 0
            let downVotes = dictionary["downVotes"] as! Int? ?? 0
            let comments = dictionary["comments"] as! [String]? ?? []
            let chosenTeam = dictionary["chosenTeam"] as! String? ?? ""
            let odds = dictionary["odds"] as! Double? ?? 0.00
            let amountWagered = dictionary["amountWagered"] as! Double? ?? 0.00
            let amountToWin = dictionary["amountToWin"] as! Double? ?? 0.00
            let documentID = dictionary["documentID"] as! String? ?? "Bad document ID?!?!?!"
            let sport = dictionary["sport"] as! String? ?? ""
            let teams = dictionary["teams"] as! [String]? ?? []
            self.init(text: text, commenceTime: commenceTime, timePosted:
                timePosted, username: username, upVotes: upVotes, downVotes: downVotes, comments: comments, chosenTeam: chosenTeam,teams: teams
                ,odds: odds, sport: sport, amountWagered: amountWagered, amountToWin: amountToWin, documentID: documentID)
        
           }
           
           convenience init() {
               let currentUserID = Auth.auth().currentUser?.email ?? "Unknown User"
            self.init(text: "", commenceTime: TimeInterval(), timePosted: TimeInterval(), username: "", upVotes: 0, downVotes: 0, comments: [], chosenTeam: "", teams: [], odds: 0.00, sport: "", amountWagered: 0.00, amountToWin: 0.00, documentID: "")
           }
        
    
    func saveData(completed: @escaping (Bool) -> ()) {
           let db = Firestore.firestore()
           //grab the userID
           guard let postingUserID = (Auth.auth().currentUser?.uid) else {
               print("Error: could not save data because we don't have a valid postingUserID")
               return completed(false)
           }
        self.pickPost?.username = postingUserID
           //create the dictionary represnting the data we want to save
           let dataToSave = self.dictionary
           //if we HAVE saved a record, we''ll have a document ID
           if self.documentID != "" {
               let ref = db.collection("pickPosts").document(self.documentID)
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
               ref = db.collection("pickPosts").addDocument(data: dataToSave) { error in
                   
                   
                   
               }
           }
           
           
           completed(true)
           
           
           
       }

    
}
