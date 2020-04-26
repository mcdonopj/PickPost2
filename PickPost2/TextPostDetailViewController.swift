//
//  TextPostViewController.swift
//  PickTalk
//
//  Created by Ann McDonough on 4/23/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import UIKit

class TextPostDetailViewController: UIViewController {
  
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var viewForComments: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var dislikeLabel: UILabel!
    @IBOutlet weak var dislikeButton: UIButton!
    
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var postButton: UIBarButtonItem!
    var textPostContent = ""
    var newTextPostText = "fake text post"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newTextPostString = textview.text {
            newTextPostText = newTextPostString
            print("new text post: \(newTextPostText)")
        }
    }
    
}



