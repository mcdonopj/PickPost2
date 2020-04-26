//
//  PickPostViewController.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/25/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseUI
import GoogleSignIn

//create an instance of PickPosts like in 2 then use the getData from that class to load all your data into the table view
class PickPostViewController: UIViewController {
    var pickPosts: PickPosts!
      var authUI: FUIAuth!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI = FUIAuth.defaultAuthUI()
              // You need to adopt a FUIAuthDelegate protocol to receive callback
              authUI?.delegate = self
              pickPostFeedTableView.delegate = self
              pickPostFeedTableView.dataSource = self
             pickPostTableView.isHidden = true
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
    
    
    

    
}









class SpotsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sortSegmentControl: UISegmentedControl!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
        spots = Spots()
//        spots.spotArray.append(Spot(name: "El Pelon", address: "Comm Ave.", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: ""))
//        spots.spotArray.append(Spot(name: "Shake Shack", address: "The Street - Chestnut Hill", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: ""))
//        spots.spotArray.append(Spot(name: "Pino's Pizza", address: "Cleveland Circle", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: ""))
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocation()
        navigationController?.setToolbarHidden(false, animated: false)
        spots.loadData {
           // self.sortBasedOnSegmentPressed()
            self.tableView.reloadData()
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
            tableView.isHidden = false
        }
    }
    
    func sortBasedOnSegmentPressed() {
        switch sortSegmentControl.selectedSegmentIndex {
        case 0: //A-Z
            spots.spotArray.sort(by: {$0.name < $1.name})
        case 1: //Closest
            spots.spotArray.sort(by: {$0.location.distance(from: currentLocation) < $1.location.distance(from: currentLocation)})
        case 2: // avg rating
            print("to do")
        default:
            print("Error")
        }
        tableView.reloadData()
    }
    
    @IBAction func sortSegmentPressed(_ sender: UISegmentedControl) {
        sortBasedOnSegmentPressed()
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        do {
            try authUI!.signOut()
            print("**** successfully signed out")
            tableView.isHidden = true
            signIn()
        } catch {
            print("Error. Couldn't sign out")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSpot" {
            let destination = segue.destination as! SpotDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.spot = spots.spotArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
}
extension SpotsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.spotArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SpotsTableViewCell
        cell.configureCell(spot: spots.spotArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}

extension SpotsListViewController: FUIAuthDelegate {
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
        tableView.isHidden = false
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


extension SpotsListViewController: CLLocationManagerDelegate {
    func getLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            print("I'm sorry - can't show location. User has not authorized it.")
        case .restricted:
            print("Access deined. Likely parental controls restrict location services in this app.")
            showAlert(title: "Access Denied.", message: "Likely parental controls restrict location services in this app.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        print("current location = \(currentLocation.coordinate.longitude), \(currentLocation.coordinate.latitude)")
        sortBasedOnSegmentPressed()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Failed to get user location")
}

}
