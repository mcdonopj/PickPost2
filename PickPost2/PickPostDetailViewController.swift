//
//  PickPostDetailViewController.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/25/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import UIKit
//PickPostsDetailView - same as the TextPostsDetailViewController but for pick posts, you might want to have a picker view in here that you can populate using Lines.getData so the user can pick a line they want to work with then a button at the bottom would save their pick to firebase, you'd do this by creating a PickPost with the information you're getting on this page (see how it all ties together?)

class PickPostDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var switcher: UISwitch!
    
    var pickPost = PickPost()
    var pickPostContent = ""
      var newPickPostText = "fake Pick post text"
    
    @IBOutlet weak var amountRiskedField: UITextField!
    
    @IBOutlet weak var amountToWinField: UITextField!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerView.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // fill in code here ❤️
        print("Im just doing 10 picker rows randomly")
        return 10
        
    }
    


    @IBOutlet weak var placeBetButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self

       
    }
   // ❤️❤️❤️❤️❤️ Do I need this prepare for segue????
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let newPickPostString = pickerView.tex //textview.text {
//               newPickPostText = newPickPostString
//               print("new text post: \(newPickPostText)")
//           }
//       }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func switchPressed(_ sender: UISwitch) {
        print("Swithcer pressed. Now switcher on? : \(switcher.isOn)")
      }

    @IBAction func placeBetButtonPressed(_ sender: UIButton) {
        if switcher.isOn {
            print("switcher is on. So You can try save data.")
        pickPost.saveData { success in
            if success {
                self.leaveViewController()
            }
            else {
                print("error couldnot leave view controller because data wasnt saved")
            }
        }
    }
        if switcher.isOn == false {
            print("The swithcer is off. You have to turn it on in order to make a pick")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let newPickPostString = pickerView.accessibilityValue  { //textview.text {
              newPickPostText = newPickPostString
              print("new text post: \(newPickPostText)")
          }
      }
    
    
    
}
