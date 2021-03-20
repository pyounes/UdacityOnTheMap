//
//  MapVC.swift
//  On The Map
//
//  Created by Pierre Younes on 3/15/21.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // Variables
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StudentServices.shared.getStudentLocations(completion: handleGetStudentLocationResponse(studentLocations:error:))
        
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        StudentServices.shared.getStudentLocations(completion: handleGetStudentLocationResponse(studentLocations:error:))
    }
    

    // MARK: - Actions
    private func handleGetStudentLocationResponse(studentLocations: [StudentLocation]?, error: Error?) {
        if let error = error {
            showAlert(message: error.localizedDescription, title: "Error")
        } else {
            if let locations = studentLocations {
                GlobalData.shared.locations = locations
                addStudentPins(studentLocations: locations)
            } else {
                showAlert(message: "Did not find any Student Locations", title: "Attention")
            }
        }
    }
    
    
    
    // Add Student Pins on Map
    func addStudentPins(studentLocations: [StudentLocation]) {
        self.mapView.removeAnnotations(self.annotations)
        self.annotations.removeAll()
        for location in studentLocations {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(location.longitude)
            let long = CLLocationDegrees(location.latitude)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = location.firstName
            let last = location.lastName
            let mediaURL = location.mediaURL
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        self.mapView.addAnnotations(annotations)
    }
    
    // Actions
    @IBAction func logout(_ sender: Any) {
        showSpinnerView()
        UserServices.shared.logout(completion: handleLogoutResponse(success:error:))
    }
    
    @IBAction func refresh(_ sender: Any) {
        showSpinnerView()
        StudentServices.shared.getStudentLocations(completion: handleGetStudentLocationResponse(studentLocations:error:))
    }
}



// MARK: MKMapViewDelegate
extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            pinView!.isEnabled = true
            pinView!.canShowCallout = true
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
                openLink(url: toOpen)
            }
        }
    }
}
