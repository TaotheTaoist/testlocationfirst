//
//  ContentViewModel.swift
//  testlocationfirst
//
//  Created by 2015 MBP 16GB 256GB on 1/23/23.
//
import CoreLocation
import Foundation
import MapKit
final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.0422448, longitude: -102.0079053),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        DispatchQueue.main.async {
            self.location = location.coordinate
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Handle any errors here...
        print (error)
    }
}
enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}
//
//
//final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var location: CLLocationCoordinate2D?
//
//    @Published var region = MKCoordinateRegion(
//        center: MapDetails.startingLocation,
//        span: MapDetails.defaultSpan
//    )
//    var locationManager: CLLocationManager?
//
//    override init() {
//        super.init()
//        locationManager?.delegate = self
//
//    }
//    func requestUserLocationForOnce() {
//        locationManager!.requestLocation()
//        }
//
//
//    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//           checkLocationAuthorization()
//           locationManager?.startUpdatingHeading()
//       }
//
//    func checkIfLocationServicesIsEnabled() {
//        DispatchQueue.main.async {
//            if CLLocationManager.locationServicesEnabled() {
//                self.locationManager = CLLocationManager()
//                self.locationManager!.delegate = self
//            } else {
//                print("Show an alert letting them know this is off and to go turn it on.")
//            }
//        }
//    }
//
//
//    private func checkLocationAuthorization() {
//
//        DispatchQueue.main.async {
//            guard let locationManager = self.locationManager else {return}
//
//            switch locationManager.authorizationStatus {
//
//            case .notDetermined:
//                locationManager.requestWhenInUseAuthorization()
//            case .restricted:
//                print("Your location is restricted likely due to parental controls")
//            case .denied:
//                print("You have denied this app location permission. Go into settings to change it.")
//            case .authorizedAlways, .authorizedWhenInUse:
//                self.region = MKCoordinateRegion(
//                    center: locationManager.location!.coordinate ,
//                    span: MapDetails.defaultSpan
//                )
//            @unknown default:
//                break
//            }
//        }
//    }
//
////    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
////            guard let latestLocation = locations.first else {return}
////
////            self.region = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
////        }
////
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            guard let location = locations.first else { return }
//
//            DispatchQueue.main.async {
//                self.location = location.coordinate
//                self.region = MKCoordinateRegion(
//                    center: location.coordinate,
//                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//                )
//            }
//        }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//            print(error.localizedDescription)
//        }
//
//}
