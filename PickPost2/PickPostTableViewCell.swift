//
//  PickPostTableViewCell.swift
//  abseil
//
//  Created by Ann McDonough on 4/25/20.
//

import UIKit

class PickPostTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var chosenTeamLineLabel: UILabel!
    var likedAlready = false
    var dislikedAlready = false
    @IBOutlet weak var profitLabl: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    var currentLikes = 0
    var currentDislikes = 0
    var pickPost = PickPost()
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
         
         let today_string = String(year!) + "-" + String(month!) + "-" + String(day!)
         
         return today_string
         
     }
     
     
     func getTimeString() -> String{
         
         let date = Date()
         let calender = Calendar.current
         let components = calender.dateComponents([.hour,.minute,.second], from: date)
         
         let hour = components.hour
         let minute = components.minute
         let second = components.second
         
         
         var ampm = ""
         if hour! < 12 {
             ampm = " AM"
         } else {
             ampm = " PM"
         }
         let time_string =  String(hour!)  + ":" + String(minute!) + ampm
         
         return time_string
         
     }
    
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!

    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timePostedLabel: UILabel!
   
    @IBOutlet weak var agreePickPostLabel: UILabel!
    @IBOutlet weak var riskingLabel: UILabel!
    @IBOutlet weak var toWinLabel: UILabel!

    @IBOutlet weak var disagreePickPostLabel: UILabel!
    
    @IBOutlet weak var disagreeButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(pickPost: PickPost) {
            // let date = NSDate(timeIntervalSince1970: timeResult)
            let commenceDate = NSDate(timeIntervalSince1970: pickPost.commence_time)
             let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = NSTimeZone() as TimeZone
        let commenceLocalDate = dateFormatter.string(from: commenceDate as Date)
        print("This is commenceDate: \(commenceDate)")
        print("This is commenceLocalDate: \(commenceLocalDate)")

        
        var time = getTimeString()
        var today = getTodayString()
        print(pickPost)
        usernameLabel.text = pickPost.username
        chosenTeamLineLabel.text = "\(pickPost.chosenTeam)" //" at \(pickPost.odds)"
        gameLabel.text = "\(pickPost.teams[0]) at \(pickPost.teams[1])"
        print("I haven't configured game Label yet")
       // gameLabel.text = "\(pickPost.teams[0]) @ \(pickPost.teams[1] ?? "")" //❤️❤️❤️❤️❤️❤️ HOw do i get game information???
        startTimeLabel.text = "\(commenceLocalDate)"
        sportLabel.text = pickPost.sport
       // timePostedLabel.text = "\(pickPost.timePosted)"
        riskingLabel.text = "Risking: $\(Double(Int(pickPost.amountWagered*100.rounded())/100))0"
        toWinLabel.text = "To Win: $\(Double(Int(pickPost.amountToWin*100.rounded())/100))0"
        agreePickPostLabel.text = "\(pickPost.upVotes)"
        disagreePickPostLabel.text = "\(pickPost.downVotes)"
        dateLabel.text = today
        timePostedLabel.text = time
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func agreeButtonPressed(_ sender: UIButton) {
        print("Agree button pressed fill in code")
        if likedAlready != true {
        pickPost.upVotes = pickPost.upVotes + 1
    currentLikes = currentLikes + 1
              //   likeLabelTextPost.text = "\(textPost.upVotes)"
        agreePickPostLabel.text = "\(currentLikes)"
        if dislikedAlready == true {
            print("We disliked it already")
                     currentDislikes = currentLikes - 1
                pickPost.downVotes = pickPost.downVotes - 1
                    // dislikeLabelTextPost.text = "\(textPost.downVotes)"
            disagreePickPostLabel.text = "\(currentDislikes)"
                     dislikedAlready = false
                 }
             likedAlready = true
        }
    }
    
    
    
    
    @IBAction func disagreeButtonPressed(_ sender: UIButton) {
        print("Disagree button pressed fill in code")
        if dislikedAlready == false {
                   currentDislikes = currentDislikes + 1
pickPost.downVotes = pickPost.downVotes + 1
// dislikeLabelTextPost.text = "\(textPost.downVotes)"
            disagreePickPostLabel.text = "\(currentDislikes)"
                   if likedAlready == true {
                       print("We liked it already")
  pickPost.upVotes = pickPost.upVotes - 1
                       currentLikes = currentLikes - 1
//  likeLabelTextPost.text = "\(textPost.upVotes)"
                    agreePickPostLabel.text = "\(currentLikes)"
                       likedAlready = false
                   }
               dislikedAlready = true
               }
    }
    
    @IBAction func agreeButtonClicked(_ sender: UIButton) {
          print("I clicked like button")
//          today = getTodayString()
//          print("Today: \(today)")
          if likedAlready == false {
              currentLikes = currentLikes + 1
              agreePickPostLabel.text = "\(currentLikes)"
              if dislikedAlready == true {
                  print("We disliked it already")
                  currentDislikes = currentLikes - 1
                  disagreePickPostLabel.text = "\(currentDislikes)"
                  dislikedAlready = false
              }
          likedAlready = true
          }
          
      }
      
      @IBAction func dislikeButtonClicked(_ sender: UIButton) {
          print("I clicked dislike button")
          if dislikedAlready == false {
              currentDislikes = currentDislikes + 1
              disagreePickPostLabel.text = "\(currentDislikes)"
              if likedAlready == true {
                  print("We liked it already")
                  currentLikes = currentLikes - 1
               agreePickPostLabel.text = "\(currentLikes)"
                  likedAlready = false
              }
          dislikedAlready = true
          }
      }
    
    
    
    
    
}
