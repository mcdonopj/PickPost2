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
    var currentLikes = 0
    var currentDislikes = 0
    var pickPost = PickPost()
    
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
        usernameLabel.text = pickPost.username
        //chosenTeamLineLabel.text = "\(pickPost.chosenTeam) at \(pickPost.odds)"
        print("I haven't configured game Label yet")
       // gameLabel.text = "\(pickPost.teams[0]) @ \(pickPost.teams[1] ?? "")" //❤️❤️❤️❤️❤️❤️ HOw do i get game information???
        startTimeLabel.text = "\(pickPost.commence_time)"
        sportLabel.text = pickPost.sport
        timePostedLabel.text = "\(pickPost.timePosted)"
        riskingLabel.text = "\(pickPost.amountWagered)"
        toWinLabel.text = "\(pickPost.amountToWin)"
        agreePickPostLabel.text = "\(pickPost.upVotes)"
        disagreePickPostLabel.text = "\(pickPost.downVotes)"
    }
    
    var addingPickPost: PickPost! {
            didSet{
                usernameLabel.text = "\(addingPickPost.pickPost?.username)"
                gameLabel.text = addingPickPost.pickPost?.text // ❤️❤️❤️ Want to set text to "away @ home"
                startTimeLabel.text = "\(addingPickPost.pickPost?.commenceTime)"
                timePostedLabel.text = "\(addingPickPost.pickPost?.timePosted)"
                riskingLabel.text = "\(addingPickPost.pickPost?.amountWagered)"
                toWinLabel.text = "\(addingPickPost.pickPost?.amountToWin)"
                agreePickPostLabel.text = "\(addingPickPost.pickPost?.upVotes)"
                disagreePickPostLabel.text = "\(addingPickPost.pickPost?.downVotes)"
         //       print("This is textpost.text: \(textPostLabel.text)")
            }
        }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func agreeButtonPressed(_ sender: UIButton) {
        print("Agree button pressed fill in code")
        pickPost.upVotes = pickPost.upVotes + 1
    }
    @IBAction func disagreeButtonPressed(_ sender: UIButton) {
        print("Disagree button pressed fill in code")
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
