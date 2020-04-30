//
//  Lines.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/24/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import Foundation


class Lines  {

    private struct Returned: Codable {
        var success: Bool
        var data: [Line]
      }
    
     var datas = [Line]()
    
    //var results: [Line] = []
    //old //var urlString ="https://api.the-odds-api//.com/v3/odds/?sport=UPCOMING&region=eu&mkt=h2h&apiKey=21f3240fa00bcfe0a554de3b68c74020"
    var urlString = "https://api.the-odds-api.com/v3/odds/?sport=UPCOMING&region=us&mkt=h2h&apiKey=d71ed9b7c01aadf3e3b885d969634a9c"
   // var APIkey = d71ed9b7c01aadf3e3b885d969634a9c
    var sites: [String] = []
    var h2h: [Double] = []
    var lineArray: [Line] = []
    var sport_nice = ""
    var teams: [String] = []
    var commence_time: TimeInterval = 0.0
    
//    private struct Data: Codable {
//        var sport_nice = ""
//        var teams: [String] = []
//        var commence_time: TimeInterval
//        var sites: [Sites]
//     //   var odds: Odds
//    }
//    
//    private struct Sites: Codable {
//        //Comment out line below, and add var site_key: String
//        //this will tell us if probelm is odds or Sites
//        var odds: Odds
//    }
//    
//      private struct Odds: Codable {
//        //try to remove the queston mark below, then keep queston mark in, can put outside brackets
//          var h2h: [Double?] = []
//      }
    
    
    func getData(completed: @escaping ()->([Line])) {
          print("🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓🏓")
          let urlString = "https://api.the-odds-api.com/v3/odds/?sport=UPCOMING&region=us&mkt=h2h&apiKey=d71ed9b7c01aadf3e3b885d969634a9c"
         // let urlString = "https://api.darksky.net/forecast/b94f0875317de54877db4feb06a79295/42.3601,-71.0589"
          print("we are accessing url string \(urlString)")
       
          //Create a URL
          guard let url = URL(string: urlString) else {
              print("Error could not create a url from \(urlString)")
              completed()
              return
          }
          
          // create session
          let session = URLSession.shared
          
          //get data with .dataTask method
          let task = session.dataTask(with: url) { (data, response, error) in
              if let error = error {
                  print("Error! \(error.localizedDescription)")
             }
              
              //deal with data
            print("Right before do function")
              do {
                print("Just got inside do function")
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                print("🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾")
                //print("Here is what you returned \(self.datas)")
                self.datas = returned.data
                print("This is datas \(self.datas)")
             //   self.lineArray.forEach({print("Teams: \($0.teams), h2h: \($0.h2h)")})
                  print("🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️🏋🏻‍♀️")
                  //let json = try JSONSerialization.jsonObject(with: data!, options: [])
                 // print("nice! json \(json)")
              }  catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
              //  print("look below")
             //   debugPrint(error)
              //   print("JSON ERROR \(error.localizedDescription)")
         completed()
      
          }
           task.resume()
//        return self.datas
    }

}

