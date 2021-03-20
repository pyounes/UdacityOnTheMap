//
//  LocationVC.swift
//  On The Map
//
//  Created by Pierre Younes on 3/18/21.
//

import UIKit
import MapKit

class LocationVC: UIViewController {

    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    
    //Variables
    var location: StudentLocation!
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showLocations(location: location)
    }
    

    @IBAction func finish(_ sender: Any) {
        if GlobalData.shared.objectID.isEmpty {
            showSpinnerView()
            StudentServices.shared.addStudentLocation(studentLocation: location, completion: handleAddStudentLocationResponse(object:error:))
        } else {
            showAlert(message: "You already Submitted a Location", title: "Error")
        }
    }
    
    // Actions
    private func handleAddStudentLocationResponse(object: AddStudentLocationResponse?, error: Error?) {
        if let error = error {
            showAlert(message: error.localizedDescription, title: "Error")
        } else {
            if let object = object {
                GlobalData.shared.objectID = object.objectId
                dismiss(animated: true, completion: nil)
            }
        }
    }

    // Show Location On the map
    private func showLocations(location: StudentLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = location.mapString
        annotation.subtitle = location.mediaURL
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)

    }
}

