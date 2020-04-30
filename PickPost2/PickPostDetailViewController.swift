//
//  PickPostDetailViewController.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/25/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import UIKit

class PickPostDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickPost = PickPost()
    var pickPostContent = ""
       var newPickPostText = "fake Pick post text"
    var currentMoneyLine = ""
    var gotLinesArray: [Line] = []
    var linesWithOdds: [Line] = []
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


    @IBOutlet weak var placeBetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        switcher.isOn = false
       // amountRiskedField.text = "\(0.00)"
     //   amountToWinField.text = "\(0.00)"
        if switcher.isOn == false {
            placeBetButton.isEnabled = false
        }
        lines.getData {
                     print("💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡💡")
                              DispatchQueue.main.async {
                             self.pickerView.reloadAllComponents()
                              }
                   //  print("in viewdidload, this is   self.lines.datas: \(self.lines.datas)")
                   //  print("in viewdidload, this is count of line array: 🟡🟡🟡🟡 \(self.lines.datas.count))🟡🟡🟡🟡🟡🟡🟡v🟡")
          //  print("This is lines.datas!!!! : \(self.lines.datas)")
            self.gotLinesArray = self.lines.datas
           // print("This is self.gotLinesArray \(self.gotLinesArray)")
           // print("This is the got Lines Array after appending: $$$$$$$$$ \(self.gotLinesArray)")
            for array in self.gotLinesArray {
                if array.sites.count != 0 {
                    self.linesWithOdds.append(array)
                }
            }
            print("This is 🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵self.lineswithOdds \(self.linesWithOdds) \(self.linesWithOdds.count)")
            return self.linesWithOdds
        }
      //  print("🟤🟤🟤🟤🟤Now that I am out of the function? do i still have access??????🟤🟤🟤🟤🟤🟤?")
        //print(self.lines.datas.count)
  //      print(self.lines.datas)
    
    //amountToWinDecimal = Decimal(amountToWinField.text)
       //amountRiskedDecimal = Decimal(amountRiskedField.text)
        convertDecimalToAmerican(decimal: 2.00)
        convertDecimalToAmerican(decimal: 1.50)
        convertDecimalToAmerican(decimal: 3.56) 
        convertDecimalToFractional(decimal: 2.00)
        convertDecimalToFractional(decimal: 1.50)
        convertDecimalToFractional(decimal: 3.56)
    }
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//       //want to return the number of different line of bets i can take
//        return self.lines.datas.count
//    }
    
    
    
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
           var newDecimalInt = Int(newDecimal)
            return "+\(newDecimalInt)"
        }
        else {
                   var newDecimal = decimal - 1.00
                   newDecimal = 100/newDecimal
             print("Old decimal = \(decimal), converted to American: -\(newDecimal)")
            var newDecimalInt = Int(newDecimal)
                   return "-\(newDecimalInt)"
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
    
//        if let newPickPostString = pickerView.accessibilityValue  { //textview.text {
//              newPickPostText = newPickPostString
//              print("new text post: \(newPickPostText)")
//          }
      }
    
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            print("pickerview 1 component might need to be changed")
          return  1
    //        return self.lines.datas.count
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            print("pickerview \(self.linesWithOdds.count) number of rows in compoenent might need to be changed")
            return self.linesWithOdds.count
        }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("THis is self.linesWithOdds \(self.linesWithOdds)")
        
      //      awayTeamButton.titleLabel?.text = "\(self.lines.datas[row].teams[0])"
        awayTeamButton.titleLabel?.text = "\(self.linesWithOdds[row].teams[0]) \(convertDecimalToAmerican(decimal: self.linesWithOdds[row].sites[0].odds.h2h.first!))"
       homeTeamButton.titleLabel?.text = "\(self.linesWithOdds[row].teams[1]) \(convertDecimalToAmerican(decimal: self.linesWithOdds[row].sites[0].odds.h2h.last!))"
      //  print("🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘 away odds:  \(self.lines.datas[0].sites[0].odds.h2h.first!)")
         // print("🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘🔘 home odds:  \(self.lines.datas[0].sites[0].odds.h2h.last!)")
       // var awayLineDecimal = self.lines.datas[row].sites //[0].odds.h2h.first!
      //  var homeLineDecimal = self.lines.datas[row].sites //[0].odds.h2h.last!
       // print("🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄")
      ///  print(awayLineDecimal)
      //   print("🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄🔄")
     //   print(homeLineDecimal)
        
  //      awayTeamButton.titleLabel?.text = "\(self.lines.datas[row].teams[0]) at \(awayLineDecimal)"
           // awayTeamButton.titleLabel?.text = "\(self.lines.datas[row].teams[0]) \(convertDecimalToAmerican(decimal: self.lines.datas[row].sites[0].odds.h2h[0]))"
     //   homeTeamButton.titleLabel?.text = "\(self.lines.datas[row].teams[1]) at //\(homeLineDecimal)"
         // homeTeamButton.titleLabel?.text = "\(self.lines.datas[row].teams[1]) \(self.lines.datas[row].sites[0].odds.h2h.last!)"
      //  print("This is my  self.lines.data 🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜\(self.lines.datas)")
                //  return "\(self.lines.datas[row])"
        print(" THis is my first picker view should look like:  \(self.linesWithOdds[row].teams[0]) @ \(self.linesWithOdds[row].teams[1]) : \(self.linesWithOdds[row].sport_nice)")
       return "\(self.linesWithOdds[row].teams[0]) @ \(self.linesWithOdds[row].teams[1]) : \(self.linesWithOdds[row].sport_nice)"
         //   return "\(self.lines.datas[row].teams[0]) @ \(self.lines.datas[row].teams[1]): \(self.lines.datas[row].sport_nice)"
      //     print("This is my  self.lines.data 🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜🔜\(self.lines.datas)")
          //  return "\(self.lines.datas[row])"
            
        //return ("\(self.gotLinesArray[row].teams[0]) @ \(self.gotLinesArray[row].teams[1])")
            print("🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶")
            print(self.gotLinesArray)
           // return "\(self.lines.getData(completed: () -> [gotLinesArray]).row)"
            //return ("\(self.gotLinesArray) @ \(self.gotLinesArray)")
       
        }
    
    
    
    
    
    
    
    
    
    
    
    
}

