//
//  TextPostFeedViewController.swift
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

class TextPostFeedViewController: UIViewController, FUIAuthDelegate, UIPageViewControllerDelegate {
    let logoImageView = UIImage(named: "beatTheBookieLogo1")
    private var pageViewController: UIPageViewController!
    private lazy var viewControllers: [UIViewController] = {
    var viewControllers = [UIViewController]()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstIntroViewController = storyboard.instantiateViewController(withIdentifier: "TextPostVC")
        let secondIntroViewController = storyboard.instantiateViewController(withIdentifier: "PickPostVC")
    viewControllers.append(firstIntroViewController)
    viewControllers.append(secondIntroViewController)
    return viewControllers
    }()
    var textPosts = TextPosts()
    var textPostHolder: [String] = []
    @IBOutlet weak var textFeedTableView: UITableView!
    var today: String!
    var time: String!
    var textPostArray: [TextPostData] = []
       var textPost: TextPost!
        var authUI: FUIAuth!
    var addingTextPost: TextPostData!
      //Do I need this? Maybe not with Posts?
    @IBOutlet weak var sortSegmentControl: UISegmentedControl!

    @IBOutlet weak var myPageControl: UIPageControl!
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
          authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
          textFeedTableView.dataSource = self
          textFeedTableView.delegate = self
//        textPosts = TextPosts()
//        textPosts.loadData {
//            print("😎😎😎😎😎😎😎😎😎😎")
//                       DispatchQueue.main.async {
//                           self.textFeedTableView.reloadData()
//                       }
//        }
      }

      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationController?.setToolbarHidden(false, animated: false)
        print("I am just beofre textposts.load data")
//        textPosts.loadData {
//            print("I am inside textposts.load data")
//            DispatchQueue.main.async {
//                 self.sortBasedOnSegmentPressed()
//                self.textFeedTableView.reloadData()
//            }
////             self.sortBasedOnSegmentPressed()
////             self.textFeedTableView.reloadData()
//            print("I am about to leave textPosts.loadData")
//                }
//        
        
        
        
   //         ❤️❤️❤️❤️❤️ textPostarray.loaddata!!!!
        textPosts.loadData { //Think I just want to load pick posts first, then try to do it with (all) posts.   Should I do pickPostArray.load data? or is this good?
       //       self.sortBasedOnSegmentPressed()
              self.textFeedTableView.reloadData()
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
         let currentUser = authUI.auth?.currentUser
          if authUI.auth?.currentUser == nil {
              self.authUI?.providers = providers
              let loginViewController = authUI.authViewController()
              loginViewController.modalPresentationStyle = .fullScreen
              present(loginViewController, animated: true, completion: nil)
          } else {
              textFeedTableView.isHidden = false
          }
      }
      
    
    
    
    @IBAction func swipeHappened(_ sender: UISwipeGestureRecognizer) {
print("I recognized the swipe")
        performSegue(withIdentifier: "SwipeToPicks", sender: UISwipeGestureRecognizer())
//        var vc = PickPostFeedViewController()
//        self.addChild(vc)
//        vc.didMove(toParent: self)
        
      //  present(PickPostFeedViewController(), animated: true)
        //pageViewController.setViewControllers([PickPostFeedViewController()], direction: .forward, animated: true, completion: nil)
  //      pageViewController.setViewControllers([TextPostFeedViewController(),PickPostFeedViewController()], direction: .forward, animated: true, completion: nil)
    }
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
           do {
               try authUI!.signOut()
               print("**** successfully signed out")
               textFeedTableView.isHidden = true
               signIn()
           } catch {
               print("Error. Couldn't sign out")
           }
           
       }
    @IBAction func createPostPressed(_ sender: UIBarButtonItem) {
        print("♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️")
        print("Im before performSegue in createPostPresed")
        performSegue(withIdentifier: "CreateTextPost", sender: sender)
        print("Im IN THE CREATE POST PREssed!")
    }
    
//    func sortBasedOnSegmentPressed() {
//           switch sortSegmentControl.selectedSegmentIndex {
//           case 0: //Popularity
//            textPosts.allTextPosts.sort(by: {$0.upVotes > $1.upVotes})
//         //  case 1: //Time????❤️❤️❤️❤️❤️
//          //     pickPosts.allPickPostsArray.sort(by: {$0.) < $1.)})
//         //  case 2: // avg rating
//        //       print("to do")
//           default:
//               print("Error")
//           }
//           textFeedTableView.reloadData()
//       }
       
    
    
//       @IBAction func sortSegmentPressed(_ sender: UISegmentedControl) {
//           sortBasedOnSegmentPressed()
//       }
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
    
    
    
     @IBAction func unwindFromViewController(segue: UIStoryboardSegue) {
        print("Im got inside the unwind functino!")
        let senderVC = segue.source as? TextPostDetailViewController
        if senderVC?.newTextPostText != "" {
            print("💡💡💡💡💡💡💡💡💡💡💡💡 full post")
        } else {
            print("😡😡😡😡😡😡 empty post")
            return
        }
        
        if segue.source is TextPostDetailViewController {
                 if let senderVC = segue.source as? TextPostDetailViewController {
                    print("segue.source is indeed textPostDetailVC")
                     textPostHolder.append(senderVC.newTextPostText)
                    print("This is textPostHolder \(textPostHolder)")
                    addingTextPost = TextPostData(text: senderVC.newTextPostText, time: TimeInterval(), postingUserID: "fake username 2", upVotes: 0, downVotes: 0, comments: [])
                   // addingTextPost = TextPostData(text: senderVC.newTextPostText, time: TimeInterval(), username: "fake username", upVotes: 0, downVotes: 0, comments: 0)
                 //   textPostArray.append(addingTextPost)
//i put it at beginning instead        // textPostArray.append(addingTextPost)
                    textPostArray.insert(addingTextPost, at: 0)

            }
        }
        print("I finished the unwind function!")
        textFeedTableView.reloadData()

       }
       
    
//❤️❤️❤️❤️❤️❤️❤️ GOT THIS FROM TODO LIST!!!
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowDetail"{
//            let destination = segue.destination as! ToDoDetailTableViewController
//            let selectedIndexPath = tableView.indexPathForSelectedRow!
//            destination.toDoItem = toDoItems[selectedIndexPath.row]
//        } else{
//            if let selectedIndexPath = tableView.indexPathForSelectedRow{
//                tableView.deselectRow(at: selectedIndexPath, animated: true)
//            }
//        }
//    }
//
//    @IBAction func unwindFromDetail(segue: UIStoryboardSegue){
//        let source = segue.source as! ToDoDetailTableViewController
//        if let selectedIndexPath = tableView.indexPathForSelectedRow{
//            toDoItems[selectedIndexPath.row] = source.toDoItem
//            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
//        } else{
//            let newIndexPath = IndexPath(row: toDoItems.count, section: 0)
//            toDoItems.append(source.toDoItem)
//            tableView.insertRows(at: [newIndexPath], with: .bottom)
//            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
//
//        }
//    }
    
    
    
    
      // do I just need to set the destination here? ❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️
//      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//             if segue.identifier == "CreatePost" {
//                print("Im in prepare!!")
//                 let destination = segue.destination as! TextPostViewController
//                // let selectedIndexPath = gameTableView.indexPathForSelectedRow!
//               //  destination.game = gamesArray[selectedIndexPath.row]
//             } else {
//                print("error with segue!!!!!")
//                 //if let selectedIndexPath = gameTableView.indexPathForSelectedRow {
//                 //    feedTableView.deselectRow(at: selectedIndexPath, animated: true)
//               //  }
//             }
//

func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let vc = segue.destination as? UIPageViewController {
 pageViewController = vc
 pageViewController.dataSource = self
 pageViewController.delegate = self
pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
 }
 }
}
// MARK: UIPageViewControllerDataSource
extension TextPostFeedViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = viewControllers.index(of: viewController) else {
 return nil
 }
 let previousIndex = viewControllerIndex-1
 
 guard previousIndex >= 0 else {
 return nil
 }
 
 guard viewControllers.count > previousIndex else {
 return nil
 }
 return viewControllers[previousIndex]
 }
 
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllers.index(of: viewController) else {
 return nil
 }
 
 let nextIndex = viewControllerIndex + 1
 let viewControllersCount = viewControllers.count
 
 guard viewControllersCount != nextIndex else {
 return nil
 }
 
 guard viewControllersCount > nextIndex else {
 return nil
 }
 return viewControllers[nextIndex]
 }
}


// MARK: UIPageViewControllerDelegate
extension TextPostFeedViewController {
 func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
 return viewControllers.count
 }
 
 func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
 return 0
 }
}







  extension TextPostFeedViewController: UITableViewDelegate, UITableViewDataSource {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          print("text posts: \(textPostArray)")
         return textPostArray.count //AFTER LOADING YOUR POSTS! ❤️❤️❤️❤️❤️
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        today = getTodayString()
        time = getTimeString()
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextPostCell", for: indexPath) as! TextPostTableViewCell
        cell.timeLabel.text = "\(time!)"
        print("↘️↘️↘️↘️↘️↘️↘️↘️↘️↘️↘️↘️ below is photoURL")
       // print(authUI.auth!.currentUser!.photoURL)
        cell.usernameLabel.text = "\(authUI.auth!.currentUser!.displayName!)"
        cell.datePostedLabel.text = "Posted: \(textPostArray[indexPath.row].time)"
        cell.datePostedLabel.text = "Posted: \(today!)"
        cell.likeLabelTextPost.text = "\(textPostArray[indexPath.row].upVotes)"
        cell.dislikeLabelTextPost.text = "\(textPostArray[indexPath.row].downVotes)"
        print("This is what im trying to st as the username 💯💯💯💯💯💯\(authUI.auth!.currentUser!.displayName!)")
        cell.textPostView.text = textPostArray[indexPath.row].text
       // cell.textLabel?.text = textPostArray[indexPath.row].textPost?.text
        print("I still need to configure the text post cell right here!!?")
      //  cell.configureCell(textPost: textPostArray[indexPath.row])
       // cell.configureCell(textPost: TextPost(textPost: TextPost))
       // cell.textLabel?.text = textPostArray[indexPath.row].text
       // cell.usernameLabel ❤️❤️❤️❤️❤️❤️❤️ How do I to put things in proper labels?????
        print("This is the user username: !!! \(textPostArray[indexPath.row].postingUserID)")
        print("Tweet:  \(textPostArray[indexPath.row].text)")
        print("This is the upvotes on the post: !!! \(textPostArray[indexPath.row].upVotes)")
        print("This is the downvotes on the post: !!! \(textPostArray[indexPath.row].downVotes)")
        print("This is the comments on the post: !!! \(textPostArray[indexPath.row].comments)")
      //  print("This is the date on the post: !!! \(textPostArray[indexPath.row].time)"
        print("Im in the function")
              return cell
      }
      
      
  }



//❤️❤️❤️❤️❤️Redundant conformance of 'TextPostFeedViewController' to protocol 'FUIAuthDelegate'
//extension TextPostFeedViewController: FUIAuthDelegate { //FUIAuthDelegate {
//      func application(_ app: UIApplication, open url: URL,
//                       options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//          let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
//        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
//          return true
//        }
//        // other URL handling goes here.
//        return false
//      }
//
//  func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
//      if let user = user {
//          print("**** we signed in with the user \(user.email ?? "unknown email")")
//          textFeedTableView.isHidden = false
//      }
//
//  }
//
//  func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
//      let loginViewController = FUIAuthPickerViewController(authUI: authUI)
//      loginViewController.view.backgroundColor = UIColor.white
//      let marginInsets: CGFloat = 16
//      let imageHeight: CGFloat = 225
//      let imageY = self.view.center.y - imageHeight
//      let logoFrame = CGRect(x: self.view.frame.origin.x + marginInsets, y: imageY, width: self.view.frame.width - (2*marginInsets), height: imageHeight)
//      let logoImageView = UIImageView(frame: logoFrame)
//      logoImageView.image = UIImage(named: "logosfake")
//      logoImageView.contentMode = .scaleAspectFit
//      loginViewController.view.addSubview(logoImageView)
//      return loginViewController
//
//  }
//
//  }
//
//
//
//
