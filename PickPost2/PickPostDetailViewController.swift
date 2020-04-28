//
//  PickPostDetailViewController.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/25/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import UIKit

class PickPostDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
//PickPostsDetailView - same as the TextPostsDetailViewController but for pick posts, you might want to have a picker view in here that you can populate using Lines.getData so the user can pick a line they want to work with then a button at the bottom would save their pick to firebase, you'd do this by creating a PickPost with the information you're
    var pickPost = PickPost()
    var pickPostContent = ""
       var newPickPostText = "fake Pick post text"
    var currentMoneyLine = ""
    var lines = Lines()
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var amountToWinField: UITextField!
    @IBOutlet weak var amountRiskedField: UITextField!
    @IBOutlet weak var amountToWInLabel: UILabel!
    var amountToWinDouble: Double = 0.0
    var amountRiskedInt: Int = 0
    var awayMoneyLineBool = false
    var homeMoneLineBool = true
    @IBOutlet weak var awayTeamButton: UIButton!
    
    @IBOutlet weak var homeTeamButton: UIButton!
    
    
    @IBOutlet weak var switcher: UISwitch!
    //    var amountToWinInt = Decimal(amountToWinField.text) ?? 0.00
//    var amountRiskedInt = Decimal(amountRiskedField.text) ?? 0.00
    
   /// ❤️❤️❤️❤️❤️❤️❤️ unsure what to do with Picker View here!!!!
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//       //want to return the number of different line of bets i can take
//        return 5
//    }
//
    //❤️❤️❤️❤️❤️❤️ here is where you say what the specific games are
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        //want to return the specific line in the array of lines
//        return array[row]
//    }
    


    @IBOutlet weak var placeBetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
//        lines.getData {
//               print("💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡")
//                        DispatchQueue.main.async {
//                        self.pickPostFeedTableView.reloadData()
//                        }
//               print("in viewdidload, this is   linearray: \(self.lines.lineArray)")
//               print("in viewdidload, this is count of line array: \(self.lines.lineArray.count))")
//           }
        switcher.isOn = false
       // amountRiskedField.text = "\(0.00)"
     //   amountToWinField.text = "\(0.00)"
        if switcher.isOn == false {
            placeBetButton.isEnabled = false
        }
        lines.getData {
                     print("💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡")
                              DispatchQueue.main.async {
                             // self.pickerView.reloadData()
                              }
                     print("in viewdidload, this is   linearray: \(self.lines.lineArray)")
                     print("in viewdidload, this is count of line array: \(self.lines.lineArray.count))")
            print("This is lines.datas!!!! : \(self.lines.datas)") 
                 }
    
    //amountToWinDecimal = Decimal(amountToWinField.text)
       //amountRiskedDecimal = Decimal(amountRiskedField.text)
        convertDecimalToAmerican(decimal: 2.00)
        convertDecimalToAmerican(decimal: 1.50)
        convertDecimalToAmerican(decimal: 3.56)
        convertDecimalToFractional(decimal: 2.00)
        convertDecimalToFractional(decimal: 1.50)
        convertDecimalToFractional(decimal: 3.56)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       //want to return the number of different line of bets i can take
        return self.lines.lineArray.count
    }
    
    
    
    func amountRiskedTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "+123567890"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        print("This is the allowed characterSet \(allowedCharacterSet)")
        print("This is teh typed chracter set \(typedCharacterSet)")
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    
   // ❤️❤️❤️❤️❤️ Do I need this prepare for segue????
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let newPickPostString = pickerView.tex //textview.text {
//               newPickPostText = newPickPostString
//               print("new text post: \(newPickPostText)")
//           }
//       }
    
    func leaveViewController() {
  
        if switcher.isOn == false {
            return
        } else {
        print("Test!!!! DO I GET IN HERE???")
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    }
    
    func convertDecimalToAmerican(decimal: Double) -> String {
        if decimal >= 2.00 {
            var newDecimal = decimal - 1.00
            newDecimal = newDecimal*100.00
            print("Old decimal = \(decimal), converted to American: +\(newDecimal)")
            return "+\(newDecimal)"
        }
        else {
                   var newDecimal = decimal - 1.00
                   newDecimal = 100/newDecimal
             print("Old decimal = \(decimal), converted to American: -\(newDecimal)")
                   return "-\(newDecimal)"
               }
        
    }
    
    func convertDecimalToFractional(decimal: Double) -> Double {
              var newFractional = decimal - 1.00
              print("Old decimal = \(decimal), converted to Fractional: \(newFractional)")
              return newFractional
      }
    
    @IBAction func awayTeamButtonPressed(_ sender: UIButton) {
        awayMoneyLineBool = true
        homeMoneLineBool = false
        currentMoneyLine = "\(awayTeamButton.titleLabel!.text!)"
        print("This is the current money line \(currentMoneyLine)")
        
    }
    
    @IBAction func homeTeamButtonPressed(_ sender: UIButton) {
        awayMoneyLineBool = false
        homeMoneLineBool = true
        currentMoneyLine = "\(homeTeamButton.titleLabel!.text!)"
            print("This is the current money line \(currentMoneyLine)")
    }
    
//    func calculateAmountWin(riskString: String) -> Decimal {
//        var riskString = amountRiskedField.text ?? "0.00"
//        var riskDecimal = Float(riskString)
//        print("riskDecimal: \(riskDecimal)!!!!!!")
//     //   riskDecimal*
//
 //   }
    
    func calculateAmountToWin(decimal: Double) -> Double {
        var winAmount = 0.00
        var oddsMultiplier = 0.00
        let number: Double!
        if let number = Double(amountRiskedField.text ?? "0.0") {
        oddsMultiplier = convertDecimalToFractional(decimal: decimal)
        winAmount = convertDecimalToFractional(decimal: decimal)*number
        }
        return winAmount
        print("This is win amount: \(winAmount). This is how much you risked: \(number).  This is the oddsMultiplier: \(oddsMultiplier)")
    }
    

    @IBAction func switchPressed(_ sender: UISwitch) {
        print("Swithcer pressed. Now switcher on? : \(switcher.isOn)")
        if switcher.isOn {
            placeBetButton.isEnabled = true
        } else {
            placeBetButton.isEnabled = false 
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
        

    @IBAction func placeBetButtonPressed(_ sender: UIButton) {
        if switcher.isOn {
            print("switcher is on. So You can try save data.")
        pickPost.saveData { success in
            if success {
                print("XXXXXXXXXXX IM GOING TO LEAVE VIEW CONTROLLER")
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
