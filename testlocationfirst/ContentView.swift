//
//  ContentView.swift
//  testlocationfirst
//
//  Created by 2015 MBP 16GB 256GB on 1/23/23.
//
import CoreLocationUI
import MapKit
import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if let location = locationManager.location {
                    Text("**Current location:** \(location.latitude), \(location.longitude)")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding()
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                Spacer()
                HStack {
                    LocationButton {
                        locationManager.requestLocation()
                    }
                    .frame(width: 180, height: 40)
                    .cornerRadius(30)
                    .symbolVariant(.fill)
                .foregroundColor(.white)
                }
                Button(action: {
                                    let newLocation = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
                                    self.locationManager.region = MKCoordinateRegion(center: newLocation, span: MapDetails.defaultSpan)
                                })
                {
                                    Text("New York City")
                                }


            }
            .padding()
        }
    }
}

//struct ContentView: View {
//    @StateObject private var viewModel = ContentViewModel()
//
//    var body: some View {
//        //shows user location IF we had permissions
//        ZStack (alignment: .bottom){
//            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
//                .ignoresSafeArea()
//                .accentColor(Color(.systemPink))
//                .onAppear{
//                    viewModel.checkIfLocationServicesIsEnabled()
//
//                }
//            HStack {
//                LocationButton(.currentLocation){
//                    viewModel.requestUserLocationForOnce()
//                }
//                .foregroundColor(.white)
//                .cornerRadius(8)
//                .padding()
//                Button(action: {
//                    let newLocation = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
//                    self.viewModel.region = MKCoordinateRegion(center: newLocation, span: MapDetails.defaultSpan)
//                }) {
//                    Text("New York City")
//                }
//                    .cornerRadius(8)
//                    .padding()
//            }
//        }
//    }
//}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

