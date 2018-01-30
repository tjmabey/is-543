//
//  MapViewController.swift
//  Map Scriptures
//
//  Created by Tyler Mabey on 11/6/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Properties
    var pins = [GeoPlace]()
    var focus = 0
    var book = Book()
    var chapter: Int = 0
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        
        mapView.mapType = .hybridFlyover
        let noLocation = CLLocationCoordinate2DMake(31.767058, 35.214095)
        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 5000000, 5000000)
        mapView.setRegion(viewRegion, animated: false)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let mapView = mapView  {
            mapView.removeAnnotations(mapView.annotations)
            dropPins()
            configureCamera()
        }
        
        
    }
    
    func dropPins() {
        if pins.count > 0 {
            for pin in pins {
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = CLLocationCoordinate2DMake(pin.latitude, pin.longitude)
                annotation.title = pin.placename
                annotation.subtitle = "\((pin.latitude * 100).rounded()/100), \((pin.longitude * 100).rounded()/100)"
                mapView.addAnnotation(annotation)
                
            }
        }
    }
    
    func configureCamera() {
        if focus != 0 {
            for pin in pins {
                if pin.id == focus {
                    let camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2DMake(pin.latitude, pin.longitude),
                                             fromEyeCoordinate: CLLocationCoordinate2DMake(pin.latitude, pin.longitude),
                                             eyeAltitude: pin.viewAltitude)
                    mapView.setCamera(camera, animated: true)
                    
                    navBar.title = pin.placename
                }
            }
            
        } else {
            if chapter != 0 {
                navBar.title = "\(book.fullName) \(chapter)"
            }
            if mapView.annotations.count > 0 {
                mapView.showAnnotations(mapView.annotations, animated: true)
            } else {
                let noLocation = CLLocationCoordinate2DMake(31.767058, 35.214095)
                let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 5000000, 5000000)
                mapView.setRegion(viewRegion, animated: true)
            }
        }
            
    }
    
    // MARK: - Map view delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "Pin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if view == nil {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            pinView.pinTintColor = UIColor.purple
            
            view = pinView
        } else {
            view?.annotation = annotation
        }
        
        return view
    }
    
    // MARK: - Helpers
    


}

