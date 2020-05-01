//
//  PickPostDetailViewController.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/25/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import UIKit

class PickPostDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var homeTeam: String = ""
    var awayTeam: String = ""
    var currentSport: String = ""
    var currentOddsMultiplierArray: [Double] = []
    var currentCommenceTime: TimeInterval = 0.0
    var currentMoneyLines: [String] = []
    var pickPost = PickPost()
    var homeOrAwayIndexForOdds = 0
    @IBOutlet weak var currentBetLabel: UILabel!
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
        currentBetLabel.text = ""
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
            self.gotLinesArray = self.lines.datas
            for array in self.gotLinesArray {
                if array.sites.count != 0 {
                    self.linesWithOdds.append(array)
                }
            }
            print("This is 🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵🎵self.lineswithOdds \(self.linesWithOdds) \(self.linesWithOdds.count)")
            return self.linesWithOdds
        }
 
        convertDecimalToAmerican(decimal: 2.00)
        convertDecimalToAmerican(decimal: 1.50)
        convertDecimalToAmerican(decimal: 3.56) 
        convertDecimalToFractional(decimal: 2.00)
        convertDecimalToFractional(decimal: 1.50)
        convertDecimalToFractional(decimal: 3.56)
    }
    
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
    
    func amountRiskedTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "+123567890"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        print("This is the allowed characterSet \(allowedCharacterSet)")
        print("This is teh typed chracter set \(typedCharacterSet)")
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
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
    
    func updateWinAmount() {
//        var riskText: String = amountRiskedField.text ?? "0"
        //var riskInt = Int(riskText)
var riskField: UITextField = amountRiskedField {
          didSet {
            print("amountToWinAmount was called")
            amountToWInLabel.text = "To Win: \(riskField.text) Multiplied by odds multiplier"
          }
        }
    }
    
    
    
//    func calculateAmountToWin() {
//        var scrapIndex = currentMoneyLine.count - 3
//        print("scrapCurrentMoneyLine \(scrapCurrentMoneyLine)")
//        for scrapIndex..<currentMoneyLine.count {
//
//        }
//
//    }
    
    
    @IBAction func awayTeamButtonPressed(_ sender: UIButton) {
        awayMoneyLineBool = true
        homeMoneLineBool = false
        currentMoneyLine = currentMoneyLines[0]
        //currentMoneyLine = "\(awayTeamButton.titleLabel!.text!)"
        currentBetLabel.text = currentMoneyLine
        print("This is the current money line \(currentMoneyLine)")
      //  awayTeamButton.titleLabel!.text = currentBetLabel.text
        homeOrAwayIndexForOdds = 0
    }
    
    @IBAction func homeTeamButtonPressed(_ sender: UIButton) {
        awayMoneyLineBool = false
        homeMoneLineBool = true
        currentMoneyLine = currentMoneyLines[1]
        //currentMoneyLine = "\(homeTeamButton.titleLabel!.text!)"
            print("This is the current money line \(currentMoneyLine)")
        homeTeamButton.titleLabel!.text = currentMoneyLine
        currentBetLabel.text = currentMoneyLine
        //homeTeamButton.titleLabel!.text = currentBetLabel.text
        homeOrAwayIndexForOdds = 1
    }
    
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
            placeBetButton.titleLabel!.textColor = .systemBlue
        } else {
            placeBetButton.isEnabled = false
              placeBetButton.titleLabel!.textColor = .lightGray
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
            self.leaveViewController()
        } else {
            print("The swithcer is off. You have to turn it on in order to make a pick")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromPickPostDetail" {
            /*
             
             */
            let selectedPickerRow = self.pickerView.selectedRow(inComponent: 0)
            let selectedLine = self.linesWithOdds[selectedPickerRow]
            
        }
        
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
        awayTeam = self.linesWithOdds[row].teams[0]
        homeTeam = self.linesWithOdds[row].teams[1]
        currentSport = self.linesWithOdds[row].sport_nice
        currentCommenceTime = self.linesWithOdds[row].commence_time
        currentOddsMultiplierArray = self.linesWithOdds[row].sites[0].odds.h2h
        
        print(" THis is my first picker view should look like:  \(self.linesWithOdds[row].teams[0]) @ \(self.linesWithOdds[row].teams[1]) : \(self.linesWithOdds[row].sport_nice)")
        awayTeamButton.titleLabel?.text = "\(self.linesWithOdds[row].teams[0]) \(convertDecimalToAmerican(decimal: self.linesWithOdds[row].sites[0].odds.h2h.first!))"
              homeTeamButton.titleLabel?.text = "\(self.linesWithOdds[row].teams[1]) \(convertDecimalToAmerican(decimal: self.linesWithOdds[row].sites[0].odds.h2h.last!))"
        currentMoneyLines = ["\(self.linesWithOdds[row].teams[0]) \(convertDecimalToAmerican(decimal: self.linesWithOdds[row].sites[0].odds.h2h.first!))", "\(self.linesWithOdds[row].teams[1]) \(convertDecimalToAmerican(decimal: self.linesWithOdds[row].sites[0].odds.h2h.last!))"]
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

