//
//  PokemonLocationViewModel.swift
//  PokedexNew
//
//  Created by Diplomado on 22/06/24.
//

import Foundation
import CoreLocation
import UIKit

protocol PokemonLocationViewModelDelegate where Self: UIViewController {
    func showPokemonLocation(coordinate: CLLocationCoordinate2D)
}

// pusimos NSObject para poder usar el delegate por que si no marca error
// ya que debe de ser una extension de NSObject
class PokemonLocationViewModel: NSObject {
    private let locationManager = CLLocationManager()
    private let pokemonLocation: CLLocationCoordinate2D?
    
    weak var delegate: PokemonLocationViewModelDelegate?
    
    private var userLocation: CLLocationCoordinate2D? {
        willSet {
            if let newValue {
                //delegate?.updateUserLocation(with: newValue)
            }
        }
    }
    
    init(pokemonLocation: CLLocationCoordinate2D?) {
        self.pokemonLocation = pokemonLocation
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension PokemonLocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        let coordinate = CLLocationCoordinate2D(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
        
        userLocation = coordinate
    }
}
