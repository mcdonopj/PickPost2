//
//  TextPostTableViewCell.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/24/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import UIKit

   class TextPostTableViewCell: UITableViewCell {
      // ❤️❤️❤️❤️❤️❤️ reformat cells and update with true date, record, winnings, and picture
    @IBOutlet weak var profilePicture: UIImageView!
    //
    var textPost = TextPostData(text: "", time: TimeInterval(), postingUserID: "", upVotes: 0, downVotes: 0)
    @IBOutlet weak var usernameLabel: UILabel!
    var likedAlready = false
    var dislikedAlready = false
    var currentLikes = 0
    var currentDislikes = 0
    var today : String!
//    today = getTodayString()
    @IBOutlet weak var textPostView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textPostLabel: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    @IBOutlet weak var likeLabelTextPost: UILabel!
    @IBOutlet weak var likeTextPostButton: UIButton!
    
    @IBOutlet weak var dislikeLabelTextPost: UILabel!
    @IBOutlet weak var dislikeTextPostButton: UIButton!
    
    @IBOutlet weak var commentLabelTextPost: UILabel!
    @IBOutlet weak var commentTextPostButton: UIButton!
    var addingTextPost: TextPost! {
            didSet{
               // dailyImageView.image = UIImage(named: dailyWeather.dailyIcon)
                usernameLabel.text = "\(addingTextPost.textPost?.postingUserID)"
                textPostView.text = addingTextPost.textPost?.text
                print("This is textpost.text: \(textPostView.text)")

            }
        }
    
    func configureCell(textPost: TextPost) {
       // usernameLabel.text =
        print("I still need to do whole configure cell for text post")
          }
          
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        print("I clicked like button")
        today = getTodayString()
        print("Today: \(today)")
        if likedAlready == false {
        textPost.upVotes = textPost.upVotes + 1
            currentLikes = currentLikes + 1
         //   likeLabelTextPost.text = "\(textPost.upVotes)"
              likeLabelTextPost.text = "\(currentLikes)"
            if dislikedAlready == true {
                print("We disliked it already")
                currentDislikes = currentLikes - 1
                textPost.downVotes = textPost.downVotes - 1
               // dislikeLabelTextPost.text = "\(textPost.downVotes)"
                    dislikeLabelTextPost.text = "\(currentDislikes)"
                dislikedAlready = false
            }
        likedAlready = true
        }
        
    }
    
    @IBAction func dislikeButtonClicked(_ sender: UIButton) {
        print("I clicked dislike button")
        if dislikedAlready == false {
            currentDislikes = currentDislikes + 1
            textPost.downVotes = textPost.downVotes + 1
           // dislikeLabelTextPost.text = "\(textPost.downVotes)"
            dislikeLabelTextPost.text = "\(currentDislikes)"
            if likedAlready == true {
                print("We liked it already")
                textPost.upVotes = textPost.upVotes - 1
                currentLikes = currentLikes - 1
              //  likeLabelTextPost.text = "\(textPost.upVotes)"
                 likeLabelTextPost.text = "\(currentLikes)"
                likedAlready = false
            }
        dislikedAlready = true
        }
    }
    
    

    func getTodayString() -> String{

                  let date = Date()
                  let calender = Calendar.current
                  let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

                  let year = components.year
                  let month = components.month
                  let day = components.day
                  let hour = components.hour
                  let minute = components.minute
                  let second = components.second

                  let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)

                  return today_string

              }
//
//          let today : String!
//
//    var today = getTodayString()
    
    

    
    
    
    
    

}

