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
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var timePostedLabel: UILabel!
    
    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var riskingLabel: UILabel!
    @IBOutlet weak var toWinLabel: UILabel!
    @IBOutlet weak var disagreeLabel: UILabel!
    
    @IBOutlet weak var disagreeButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(pickPost: PickPost) {
        usernameLabel.text = pickPost.username
        chosenTeamLineLabel.text = "\(pickPost.chosenTeam) at \(pickPost.odds)"
        print("I haven't configured game Label yet")
        gameLabel.text = "\(pickPost.chosenTeam): away @ home" //❤️❤️❤️❤️❤️❤️ HOw do i get game information???
        startTimeLabel.text = "\(pickPost.commenceTime)"
        timePostedLabel.text = "\(pickPost.timePosted)"
        riskingLabel.text = "\(pickPost.amountWagered)"
        toWinLabel.text = "\(pickPost.amountToWin)"
        agreeLabel.text = "\(pickPost.upVotes)"
        disagreeLabel.text = "\(pickPost.downVotes)"
    }
    
    var addingPickPost: PickPost! {
            didSet{
                usernameLabel.text = "\(addingPickPost.pickPost?.username)"
                gameLabel.text = addingPickPost.pickPost?.text // ❤️❤️❤️ Want to set text to "away @ home"
                startTimeLabel.text = "\(addingPickPost.pickPost?.commenceTime)"
                timePostedLabel.text = "\(addingPickPost.pickPost?.timePosted)"
                riskingLabel.text = "\(addingPickPost.pickPost?.amountWagered)"
                toWinLabel.text = "\(addingPickPost.pickPost?.amountToWin)"
                agreeLabel.text = "\(addingPickPost.pickPost?.upVotes)"
                disagreeLabel.text = "\(addingPickPost.pickPost?.downVotes)"
         //       print("This is textpost.text: \(textPostLabel.text)")
            }
        }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func agreeButtonPressed(_ sender: UIButton) {
        print("Agree button pressed fill in code")
    }
    @IBAction func disagreeButtonPressed(_ sender: UIButton) {
        print("Disagree button pressed fill in code")
    }
    
}
