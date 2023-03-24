//
//  ViewModel.swift
//  Bucketlist
//
//  Created by Onur Celik on 24.03.2023.
//

import Foundation
import MapKit
import LocalAuthentication
extension ContentView{
  @MainActor  class ViewModel : ObservableObject{
        
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
                                                      span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        @Published  private (set) var locations: [Location]
        @Published var selectedLocation: Location?
      @Published var isUnlocked = false
      
      let savePath = FileManager.documentsDirectory.appending(path: "SavedPlaces")
      init(){
          do{
              let data = try Data(contentsOf: savePath)
              locations = try JSONDecoder().decode([Location].self, from: data)
          }catch{
              locations = []
          }
      }
      func save(){
          do{
              let data = try JSONEncoder().encode(locations)
              try data.write(to: savePath,options: [.atomic,.completeFileProtection])
          }catch{
              print("Unable to save data")
          }
      }
        
        func addLocation(){
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
      func updateLocation(location:Location){
          guard let selectedLocation = selectedLocation else {return}
          if let index = locations.firstIndex(of: selectedLocation){
              locations[index] = location
          }
          save()
      }
      func authenticate(){
          let context = LAContext()
          var error: NSError?
          if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
              let reason = "We need to unlock your data"
              context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                  if success{
                      Task{ @MainActor in
                          self.isUnlocked = true
                      }
                      
                  }
              }
          }else{
              
          }
      }
    }
}
