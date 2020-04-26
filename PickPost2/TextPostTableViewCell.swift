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
       //
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var textPostView: UITextView!
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
                usernameLabel.text = "\(addingTextPost.textPost?.username)"
                textPostView.text = addingTextPost.textPost?.text
                print("This is textpost.text: \(textPostView.text)")
                
                
                
            }
        }
    
    func configureCell(textPost: TextPost) {
       // usernameLabel.text =
        print("I still need to do whole configure cell for text post")
          }
          

    

   }

