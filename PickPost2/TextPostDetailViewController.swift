//
//  TextPostViewController.swift
//  PickTalk
//
//  Created by Ann McDonough on 4/23/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import UIKit
import CoreGraphics

class TextPostDetailViewController: UIViewController {
    var textPost: TextPost!
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
        textview.layer.borderColor = UIColor.black.cgColor
        textview.layer.borderWidth = 1
    }
  
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
           if isPresentingInAddMode{
               dismiss(animated: true, completion: nil )
           } else {
               navigationController?.popViewController(animated: true)
           }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode{
            dismiss(animated: true, completion: nil )
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func postButtonPressed(_ sender: UIBarButtonItem) {
        textPost.saveData { success in
            if success {
                self.leaveViewController()
            } else {
                print("Error couldnt leave this view controller because data wasnt savd")
            }
        }
        
    }
    
    
    
//    let secondViewController = self.(<#T##self: TextPostDetailViewController##TextPostDetailViewController#>)  instantiateViewControllerWithIdentifier("PickPostFeedViewController") as PickPostFeedViewController
//
//    self.navigationController.pushViewController(secondViewController, animated: true)
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newTextPostString = textview.text {
            newTextPostText = newTextPostString
            print("new text post: \(newTextPostText)")
        }
    }
    
}



