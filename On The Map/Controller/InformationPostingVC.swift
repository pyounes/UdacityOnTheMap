//
//  InformationPostingVC.swift
//  On The Map
//
//  Created by Pierre Younes on 3/18/21.
//

import UIKit
import MapKit

class InformationPostingVC: UIViewController {

    // Outlets
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtLink: UITextField!
    
    // Variables
    var location: StudentLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    
    // MARK: - Actions
    @IBAction func findLocation(_ sender: Any) {
        if let location = txtLocation.text, let link = txtLink.text {
            self.findLocationFromString(txt: location, link: link) { success in
                if !success { return }
                self.pushLocationVC(location: self.location)
            }
        } else {
            showAlert(message: "Either location is Empty or link is empty", title: "Attetion")
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func findLocationFromString(txt: String, link: String, completion: @escaping (Bool) -> Void) {
        showSpinnerView()
        CLGeocoder().geocodeAddressString(txt) { (placeMarks, error) in
            if let location = placeMarks?.first?.location, error == nil {
                self.location = StudentLocation(objectId: nil,
                                           uniqueKey: GlobalData.shared.uniqueKey,
                                           firstName: GlobalData.shared.firstName,
                                           lastName: GlobalData.shared.lastName,
                                           mapString: txt,
                                           mediaURL: link,
                                           longitude: location.coordinate.longitude,
                                           latitude: location.coordinate.latitude,
                                           createdAt: nil,
                                           updatesAt: nil)
                completion(true)
            } else {
                self.showAlert(message: "There was an error Pinning Your Location, Please type your location again", title: "Error")
                completion(false)
            }
        }
    }

    
}
