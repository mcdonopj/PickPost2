//
//  Lines.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/24/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//

import Foundation


class Lines: Codable {
    var lineArray: [Line] = []
    
    private struct Returned: Codable {
        var results: [Line]
       var h2h: [String] = []
         //gonna have to convert to decimalss
         var sportNice: String
         var teams: [String] = []
         var commenceTime: String // gonna have to convert to time
         var sites: [String] = []
         var siteKey: String
         var siteNice: String
         var lastUpdate: String // gonna have to convert to time
    }
    
    
    var name: String
    var latitude: Double
    var longitude: Double

    init(name: String, latitude: Double, longitude: Double){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
//    func fetchFilms(completionHandler: @escaping ([Film]) -> Void) {
//      let url = URL(string: domainUrlString + "films/")!
//
//      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//        if let error = error {
//          print("Error with fetching films: \(error)")
//          return
//        }
//
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode) else {
//          print("Error with the response, unexpected status code: \(response)")
//          return
//        }
//
//        if let data = data,
//          let filmSummary = try? JSONDecoder().decode(FilmSummary.self, from: data) {
//          completionHandler(filmSummary.results ?? [])
//        }
//      })
//      task.resume()
//    }
    
//
//
//    func saveData(spot: Spot, completed: @escaping (Bool) -> ()) {
//           let db = Firestore.firestore()
//
//        let storage = Storage.storage()
//        //CONVERT photo.image to a Data type so it can be saved by firebase storage
//        guard let photoData = self.image.jpegData(compressionQuality: 0.5) else {
//            print("**** ERror could not convet image to data format")
//            return(completed(false))
//        }
//        documentUUID = UUID().uuidString //generate a unique ID to use for the phot image's name
//        //create a ref to upload storage to spot.documentID's folder (bucket), with the name we created
//        let storageRef = storage.reference().child(spot.documentID).child(self.documentUUID)
//        let uploadTask = storageRef.putData(photoData)
//        uploadTask.observe(.success) { (snapshot) in
//            //create the dictionary represnting the data we want to save
//            let dataToSave = self.dictionary
//            //if we HAVE saved a record, we''ll have a document ID
//              let ref = db.collection("spots").document(spot.documentID).collection("photos").document(self.documentUUID)
//                ref.setData(dataToSave) { (error) in
//                    if let error = error {
//                      print("Error: creating new document \(self.documentUUID) in \(spot.documentID)")
//                        completed(false)
//                    } else {
//                        print("new document created with ref ID \(ref.documentID)")
//                        completed(true)
//                    }
//                }
//            completed(true)
//        }
//    uploadTask.observe(.failure) { (snapshot) in
//            if let error = snapshot.error {
//                print("*** error: upload task for file \(self.documentUUID) failed, in spot \(spot.documentID)")
//            }
//            return completed(false)
//        }
//
//
//
//    }
    
    
    
      func getData(completed: @escaping ()->()) {
        let urlString = "https://api.the-odds-api.com/v3/odds/?sport=UPCOMING&region=eu&mkt=h2h&apiKey=21f3240fa00bcfe0a554de3b68c74020"
               print("we are accessing url string \(urlString)")
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
                 do {
                    let returned = try JSONDecoder().decode(Line.self, from: data!)
                    self.lineArray.append(returned)
                    print("here is what your returned, returned \(returned)")
                  print("Here is what the line array you returned \(self.lineArray)")
                    print("Here is details of what your returned now teams: \(returned.teams)")
                    print("Here is details of what your returned now sportNice: \(returned.sportNice)")
                    print("Here is details of what your returned now teams: \(returned.h2h)")
                       print("Here is details of what your returned now away team odds: \(returned.h2h[0])")
                print("Here is details of what your returned now home team odds: \(returned.h2h[1])")
                    print("Here is details of what your returned now commenceTime: \(returned.commenceTime)")
                 } catch {
                     print("JSON ERROR \(error.localizedDescription)")
                 }
            completed()
             }
              task.resume()
         }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//
//
//    func getData(completionHandler: @escaping ([PickPost]) -> Void) {
//     //   let coordinates = "\(latitude),\(longitude)"
//       // let urlString = "\(APIurls.darkSkyURL)\(APIKeys.darkSkyKey)/\(coordinates)"
//       let urlString = "https://api.the-odds-api.com/v3/odds/?sport=UPCOMING&region=eu&mkt=h2h&apiKey=21f3240fa00bcfe0a554de3b68c74020"
//        print("we are accessing url string \(urlString)")
//
//        //Create a URL
//        guard let url = URL(string: urlString) else {
//            print("Error could not create a url from \(urlString)")
//            return
//        }
//
//        // create session
//        let session = URLSession.shared
//
//        //get data with .dataTask method
//        let task = session.dataTask(with: url { (data, response, error) in
//            if let error = error {
//                print("Error! \(error.localizedDescription)")
//           }
//
//
//            //deal with data like this?
//            if let data = data {
//              let pickPostData = try? JSONDecoder().decode(PickPostData.self, from: data) {
//               // completionHandler(. ?? [])
//            }
//
//            //deal with data or this?
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                print("nice! json \(json)")
//            } catch {
//                print("JSON ERROR \(error.localizedDescription)")
//            }
//
//        }
//    task.resume()
//
//        }
//


}

