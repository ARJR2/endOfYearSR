//
//  ViewController.swift
//  endOfYearSR
//
//  Created by Aeneas Reynolds on 4/11/23.
//

import UIKit
import MapKit
import CoreLocation
import Foundation

class ViewController: UIViewController {

    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        title = "Home"
        LocationManger.shared.getUserLocation { [weak self]
            location in DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.addMapPin(with: location)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }

    func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
        map.addAnnotation(pin)
        
        LocationManger.shared.resolveLocationName(with: location) { [weak self] locationName in self?.title = locationName
            
        }
    }
    
}

