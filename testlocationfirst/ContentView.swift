//
//  ContentView.swift
//  testlocationfirst
//
//  Created by 2015 MBP 16GB 256GB on 1/23/23.
//
import CoreLocationUI
import MapKit
import SwiftUI


struct ContentView: View{
//    let customAnnotation = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054))
    @StateObject var locationManager = LocationManager()
    let annotations = [
            City(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 37.39149759708518, longitude: -122.08104083062568))
           
        ]
    
    var body: some View {
        ZStack(alignment: .bottom) {

//            Map(coordinateRegion: $locationManager.region,showsUserLocation: true)
//                .edgesIgnoringSafeArea(.all)
            Map(coordinateRegion: $locationManager.region,showsUserLocation: true,annotationItems: annotations)
            {
                       MapMarker(coordinate: $0.coordinate)
                   }
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
                    Button(action: {
                        let newLocation = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
                        self.locationManager.region = MKCoordinateRegion(center: newLocation, span: MapDetails.defaultSpan)
                    })
                    {
                        Text("New York City")
                    }
                    
                }
            }
            .padding()
        }
    }
}

//class CustomAnnotation: NSObject, MKAnnotation,Identifiable {
//    var coordinate: CLLocationCoordinate2D
//
//    init(coordinate: CLLocationCoordinate2D) {
//        self.coordinate = coordinate
//    }
//}
//struct MapView: UIViewRepresentable {
//    var annotations: [MKAnnotation]
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.addAnnotations(annotations)
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        uiView.addAnnotations(annotations)
//    }
//}
struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

