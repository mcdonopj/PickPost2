//
//  PickPostFeedViewController.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/24/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseUI
import GoogleSignIn

//create an instance of PickPosts like in 2 then use the getData from that class to load all your data into the table view
class PickPostFeedViewController: UIViewController {
    var pickPosts: PickPosts!
      var authUI: FUIAuth!
    var pickPostTextHolder: [String] = []
    var pickPostArray: [PickPostData] = []
    var addingPickPost: PickPostData!
    @IBOutlet weak var sortSegmentControl: UISegmentedControl!
    @IBOutlet weak var pickPostFeedTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI = FUIAuth.defaultAuthUI()
              // You need to adopt a FUIAuthDelegate protocol to receive callback
              authUI?.delegate = self
              pickPostFeedTableView.delegate = self
              pickPostFeedTableView.dataSource = self
             pickPostFeedTableView.isHidden = true
        print("The table view is hidden here ❤️❤️❤️ ")
        pickPosts = PickPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        //   navigationController?.setToolbarHidden(false, animated: false) ❤️❤️❤️
           pickPosts.loadData {
        self.sortBasedOnSegmentPressed()
        self.pickPostFeedTableView.reloadData()
           }
          }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           signIn()
       }
       
       func signIn() {
           let providers: [FUIAuthProvider] = [
               FUIGoogleAuth(),
           ]
          // let currentUser = authUI.auth?.currentUser
           if authUI.auth?.currentUser == nil {
               self.authUI?.providers = providers
               let loginViewController = authUI.authViewController()
               loginViewController.modalPresentationStyle = .fullScreen
               present(loginViewController, animated: true, completion: nil)
           } else {
               pickPostFeedTableView.isHidden = false
           }
       }
    
    func sortBasedOnSegmentPressed() {
        switch sortSegmentControl.selectedSegmentIndex {
        case 0: //Popularity
            pickPosts.allPickPostsArray.sort(by: {$0.upVotes > $1.upVotes})
      //  case 1: //Time????❤️❤️❤️❤️❤️
       //     pickPosts.allPickPostsArray.sort(by: {$0.) < $1.)})
      //  case 2: // avg rating
     //       print("to do")
        default:
            print("Error")
        }
        pickPostFeedTableView.reloadData()
    }
    
    @IBAction func sortSegmentPressed(_ sender: UISegmentedControl) {
        sortBasedOnSegmentPressed()
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        do {
            try authUI!.signOut()
            print("**** successfully signed out")
            pickPostFeedTableView.isHidden = true
            signIn()
        } catch {
            print("Error. Couldn't sign out")
        }
        
    }
  
    @IBAction func createBetPressed(_ sender: UIBarButtonItem) {
   print("♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️")
       print("Im before performSegue CreatePickPost")
       performSegue(withIdentifier: "CreatePickPost", sender: sender)
       print("Im IN THE Place Bet PREssed!")
    }
    
//DONT THINK I NEEd this??????
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "CreatePickPost" {
//
//            print("Just got past perform segue!")
//            let destination = segue.destination as! PickPostDetailViewController
//            let selectedIndexPath = pickPostFeedTableView.indexPathForSelectedRow!
//            destination.pickPost = pickPosts.allPickPostsArray[selectedIndexPath.row]
//        } else {
//            if let selectedIndexPath = pickPostFeedTableView.indexPathForSelectedRow {
//                pickPostFeedTableView.deselectRow(at: selectedIndexPath, animated: true)
//            }
//        }
//    }
    
    @IBAction func unwindFromViewController(segue: UIStoryboardSegue) {
         print("Im got inside the unwind functino!")
         
         
         if segue.source is PickPostDetailViewController {
                  if let senderVC = segue.source as? PickPostDetailViewController {
                     print("segue.source is indeed PickPostDetailVC")
                      pickPostTextHolder.append(senderVC.newPickPostText)
                     print("This is pickPostHolder \(pickPostTextHolder)")
                     //addingPickPost = PickPostData(text: senderVC.newTextPostText, time: Date(), username: "fake username 2", upVotes: 0, downVotes: 0, comments: [])
                    //❤️❤️❤️❤️❤️ Should I add senderVC.newPickPostText as text: instead??????
                    addingPickPost = PickPostData(text: senderVC.pickPost.text, commenceTime: senderVC.pickPost.commenceTime, timePosted: senderVC.pickPost.timePosted, username: senderVC.pickPost.username, upVotes: senderVC.pickPost.upVotes, downVotes: senderVC.pickPost.downVotes, chosenTeam: senderVC.pickPost.chosenTeam, odds: senderVC.pickPost.odds, amountWagered: senderVC.pickPost.amountWagered, amountToWin: senderVC.pickPost.amountToWin, documentID: senderVC.pickPost.documentID)
                    // addingTextPost = TextPostData(text: senderVC.newTextPostText, time: Date(), username: "fake username", upVotes: 0, downVotes: 0, comments: 0)
                  //   textPostArray.append(addingTextPost)
                     pickPostArray.insert(addingPickPost, at: 0)
                    print("This is the pick post array now: \(pickPostArray)")

             }
         }
         print("I finished the unwind function!")
         pickPostFeedTableView.reloadData()

        }
    
// ❤️❤️❤️❤️❤️❤️ Do I need this at all?
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "ShowPickPost" {
//                let destination = segue.destination as! PickPostDetailViewController
//                let selectedIndexPath = pickPostFeedTableView.indexPathForSelectedRow!
//                destination.pickPost = pickPosts.allPickPostsArray[selectedIndexPath.row]
//            } else {
//                if let selectedIndexPath = pickPostFeedTableView.indexPathForSelectedRow {
//                    pickPostFeedTableView.deselectRow(at: selectedIndexPath, animated: true)
//                }
//            }
//        }
        
    func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    

    
}

extension PickPostFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickPosts.allPickPostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickPostCell", for: indexPath) as! PickPostTableViewCell
        print("Why doesnt is like configure cell? ❤️❤️❤️❤️❤️❤️❤️")
        cell.configureCell(pickPost: pickPosts.allPickPostsArray[indexPath.row])
        cell.textLabel?.text = pickPosts.allPickPostsArray[indexPath.row].text
        print("This is the pick post text: \(pickPosts.allPickPostsArray[indexPath.row].text)")
        
        print("This is the chosen team of the pick post: \(pickPosts.allPickPostsArray[indexPath.row].chosenTeam)")
        print("This is the pick post amountWagered: \(pickPosts.allPickPostsArray[indexPath.row].amountWagered)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
        print("I made cell here 140 randomly")
    }

}

extension PickPostFeedViewController: FUIAuthDelegate {
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
      if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
        return true
      }
      // other URL handling goes here.
      return false
    }

func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
    if let user = user {
        print("**** we signed in with the user \(user.email ?? "unknown email")")
        pickPostFeedTableView.isHidden = false
    }
    
}
 
func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
    let loginViewController = FUIAuthPickerViewController(authUI: authUI)
    loginViewController.view.backgroundColor = UIColor.white
    let marginInsets: CGFloat = 16
    let imageHeight: CGFloat = 225
    let imageY = self.view.center.y - imageHeight
    let logoFrame = CGRect(x: self.view.frame.origin.x + marginInsets, y: imageY, width: self.view.frame.width - (2*marginInsets), height: imageHeight)
    let logoImageView = UIImageView(frame: logoFrame)
    logoImageView.image = UIImage(named: "logo")
    logoImageView.contentMode = .scaleAspectFit
    loginViewController.view.addSubview(logoImageView)
    return loginViewController
    
}

}







































