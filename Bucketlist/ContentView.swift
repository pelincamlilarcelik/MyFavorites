//
//  ContentView.swift
//  Bucketlist
//
//  Created by Onur Celik on 23.03.2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    var body: some View {
        if vm.isUnlocked{
            ZStack{
                
                Map(coordinateRegion: $vm.mapRegion,
                    annotationItems: vm.locations,
                    annotationContent: { location in
                    MapAnnotation(coordinate:location.coordinate){
                        VStack{
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.yellow)
                                .frame(width:44,height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            vm.selectedLocation = location
                        }
                    }
                    
                    
                })
                .ignoresSafeArea()
                
                Circle()
                    .foregroundColor(.blue.opacity(0.5))
                    .frame(width:32,height: 32)
                
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button {
                            vm.addLocation()
                        } label: {
                            Image(systemName: "plus")
                            
                        }
                        .padding()
                        .font(.title)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.6))
                        .clipShape(Circle())
                        .padding(.trailing)
                        
                    }
                }
                
                
            }
            .sheet(item: $vm.selectedLocation) { place in
                EditView(location: place) { newLocation in
                    vm.updateLocation(location: newLocation)
                }
            }
        }else{
            Button {
                vm.authenticate()
            } label: {
                Text("Authenticate")
            }
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(Capsule())

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
