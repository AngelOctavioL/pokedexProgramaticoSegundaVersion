//
//  PokemonLocationViewController.swift
//  PokedexNew
//
//  Created by Diplomado on 21/06/24.
//

import UIKit

//modulo de los mapas
import MapKit

//modulo de la geolocalizacion
import CoreLocation

class PokemonLocationViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        
        // pin azul
        mapView.showsUserLocation = true
        
        return mapView
    }()
    
    // crear la variable para acceder a las propiedades de la ubicacion
    private let locationManager = CLLocationManager()
    //private var viewModel = PokemonLocationViewModel()
    
    init(pokemonLocation: Pokemon.Location?) {
        if let location = pokemonLocation {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            viewModel = PokemonLocationViewModel(pokemonLocation: coordinate)
        } else {
            
        }
        

        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        setupView()
    }
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.tintColor = .white
        button.setTitle("Cerrar", for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(mapView)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc
    func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension PokemonLocationViewController: PokemonLocationViewModelDelegate {
    func updateUserLocation(with coordinate: CLLocationCoordinate2D) {
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = coordinate
        mapView.addAnnotation(userAnnotation)

        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        mapView.region = mapRegion
    }
}
