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
    var pickPosts = PickPosts()
    var authUI: FUIAuth!
    var pickPostTextHolder: [String] = []
    // var pickPostArray: [PickPostData] = []
    var addingPickPost: PickPost!
    var today: String!
    var time: String!
    var lines = Lines()
    // var pickPostArray = [PickPostData]()
    @IBOutlet weak var sortSegmentControl: UISegmentedControl!
    @IBOutlet weak var pickPostFeedTableView: UITableView!
    @IBOutlet weak var mysecondpageControl: UIPageControl!
    
    /*
    var pickPostArray = [PickPost]() {
        didSet {
            DispatchQueue.main.async {
                self.pickPostFeedTableView.reloadData()
            }
            
        }
    }
        */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mysecondpageControl.currentPage = 1
        authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self
        pickPostFeedTableView.dataSource = self
        pickPostFeedTableView.delegate = self
        pickPostFeedTableView.isHidden = true
        print("The table view is hidden here ❤️❤️❤️ ")
        pickPosts.loadData {
            print("💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡")
            DispatchQueue.main.async {
                self.pickPostFeedTableView.reloadData()
            }
        }
        
        //        lines.getData {
        //            print("💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡")
        //                     DispatchQueue.main.async {
        //                     self.pickPostFeedTableView.reloadData()
        //                     }
        //            print("in viewdidload, this is   linearray: \(self.lines.lineArray)")
        //            print("in viewdidload, this is count of line array: \(self.lines.lineArray.count))")
        //        }
        // updateUserInterface()
        
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
    
    /*
    func updateUserInterface() {
        pickPosts.getData {
            //  print("This is in the get data function.")
            DispatchQueue.main.async {
                // dateformatter.timeZone = TimeZone(identifier: self.weatherDetail.timezone)
                // dateFormatter.timeZone = TimeZone(identifier: weatherDetail.timezone)
                //  let usableDate = Date(timeIntervalSince1970: self.weatherDetail.currentTime)
                //  self.dateLabel.text = dateformatter.string(from: usableDate)
                //                 //  self.dateLabel.text = dateFormatter.string(from: usableDate)
                //                 self.locationLabel.text = self.weatherDetail.name
                //                 self.tempteratureLabel.text = "\(self.weatherDetail.temperature)°"
                //                 self.summaryLabel.text = self.weatherDetail.summary
                //                 self.imageView.image = UIImage(named: self.weatherDetail.dailyIcon)
                //                 self.tableView.reloadData()
                //                 self.collectionView.reloadData()
            }
        }
    }
 */
    
    @IBAction func swipeToTexts(_ sender: UISwipeGestureRecognizer) {
        print("swipe back was recognized 🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰")
        performSegue(withIdentifier: "SwipeToTexts", sender: UISwipeGestureRecognizer())
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
    
    //    func getTodayString() -> String{
    //
    //                  let date = Date()
    //                  let calender = Calendar.current
    //                  let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    //
    //                  let year = components.year
    //                  let month = components.month
    //                  let day = components.day
    //                  let hour = components.hour
    //                  let minute = components.minute
    //                  let second = components.second
    //
    //                  let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
    //
    //                  return today_string
    //
    //              }
    //
    //          let today : String!
    //          today = getTodayString()
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
        let senderVC = segue.source as! PickPostDetailViewController
        let number = Int(senderVC.amountRiskedField.text ?? "0")!
        print("Im got inside the unwind functino!")
        addingPickPost = PickPost(text: senderVC.pickPost.text, commenceTime: senderVC.currentCommenceTime, timePosted: senderVC.pickPost.timePosted, username: "\(authUI.auth!.currentUser!.displayName!)" /*senderVC.pickPost.username*/, upVotes: senderVC.pickPost.upVotes, downVotes: senderVC.pickPost.downVotes, comments: [], chosenTeam: senderVC.currentBetLabel!.text!, teams: [senderVC.awayTeam, senderVC.homeTeam] /*senderVC.pickPost.teams*/, odds: senderVC.currentOddsMultiplierArray[senderVC.homeOrAwayIndexForOdds], sport: senderVC.currentSport, amountWagered:  Double(number), amountToWin: Double(number)*(senderVC.currentOddsMultiplierArray[senderVC.homeOrAwayIndexForOdds]-1), documentID: senderVC.pickPost.documentID)
        print("******* Adding \(addingPickPost!.toString())")
        // addingTextPost = TextPostData(text: senderVC.newTextPostText, time: Date(), username: "fake username", upVotes: 0, downVotes: 0, comments: 0)
        //   textPostArray.append(addingTextPost)
        pickPosts.allPickPostsArray.insert(addingPickPost, at: 0)
        print("This is the pick post array now: ")
        for post in pickPosts.allPickPostsArray {
            print(post.toString())
        }
        // pickPostArray[0].teams = [senderVC.awayTeam, senderVC.homeTeam]
                            
        print("I finished the unwind function!")
        pickPostFeedTableView.reloadData()
        
        addingPickPost.saveData { (status) in
            print("Save New Pick Post was successfull: \(status)")
            if status {
                DispatchQueue.main.async {
                    self.pickPostFeedTableView.reloadData()
                }
            }
            
        }
        
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
        let time = getTimeString()
        let today = getTodayString()
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickPostCell", for: indexPath) as! PickPostTableViewCell
        print("Why doesnt is like configure cell? ❤️❤️❤️❤️❤️❤️❤️")
        cell.configureCell(pickPost: pickPosts.allPickPostsArray[indexPath.row])
        /*
         cell.usernameLabel.text = "\(authUI.auth!.currentUser!.displayName!)"
         cell.chosenTeamLineLabel.text = "Chosen Team -XXX Goes Here" // pickPostArray[indexPath.row].chosenTeam //"Chosen Team -XXX Goes Here"
         cell.timePostedLabel.text = "\(time)"
         cell.dateLabel.text = "Posted: \(today)"
         cell.startTimeLabel.text = "start time goes here" //"\(pickPostArray[indexPath.row].commenceTime)"//"Start time Goes in Here"
         cell.riskingLabel.text = "risk label goes here" //"\(pickPostArray[indexPath.row].amountWagered)"
         cell.toWinLabel.text = " to win goes here" //"\(pickPostArray[indexPath.row].amountToWin)"
         print("🎛🎛🎛🎛🎛🎛🎛🎛 about to post day and time posted")
         print("I am commentng out everything below htis because of index range failures for pickPostArray[indexPath.row].username or .whatever")
         //        print("This is the username \(pickPostArray[indexPath.row].username)")
         //        print("This is the chosen team \(pickPostArray[indexPath.row].chosenTeam)")
         //        print("This is the time Posted \(pickPostArray[indexPath.row].timePosted)")
         //        print("This is the commence Time \(pickPostArray[indexPath.row].commenceTime)")
         //        print("This is the amount wagered \(pickPostArray[indexPath.row].amountWagered)")
         //        print("This is the amount to win  \(pickPostArray[indexPath.row].amountToWin)")
         //        print("This is the amount agrees \(pickPostArray[indexPath.row].upVotes)")
         //        print("This is the amount disagrees \(pickPostArray[indexPath.row].downVotes)")
         print(today)
         print(time)
         
         cell.textLabel?.text = pickPosts.allPickPostsArray[indexPath.row].text
         print("This is the pick post text: \(pickPosts.allPickPostsArray[indexPath.row].text)")
         
         print("This is the chosen team of the pick post: \(pickPosts.allPickPostsArray[indexPath.row].chosenTeam)")
         print("This is the pick post amountWagered: \(pickPosts.allPickPostsArray[indexPath.row].amountWagered)")
         */
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







































