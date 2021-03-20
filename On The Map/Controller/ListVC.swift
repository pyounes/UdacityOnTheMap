//
//  ListVC.swift
//  On The Map
//
//  Created by Pierre Younes on 3/18/21.
//

import UIKit

class ListVC: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // Actions
    private func handleGetStudentLocationResponse(studentLocations: [StudentLocation]?, error: Error?) {
        if let error = error {
            showAlert(message: error.localizedDescription, title: "Error")
        } else {
            tableView.reloadData()
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        showSpinnerView()
        UserServices.shared.logout(completion: handleLogoutResponse(success:error:))
    }
    
    @IBAction func refresh(_ sender: Any) {
        showSpinnerView()
        StudentServices.shared.getStudentLocations(completion: handleGetStudentLocationResponse(studentLocations:error:))
    }
}


// MARK: - TableView Delegate
extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalData.shared.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GConstants.Identifiers.studentLocationCell, for: indexPath)
        let location = GlobalData.shared.locations[indexPath.row]
        cell.textLabel?.text = "\(location.firstName)" + " " + "\(location.lastName)"
        cell.detailTextLabel?.text = "\(location.mediaURL)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = GlobalData.shared.locations[indexPath.row]
        openLink(url: location.mediaURL)
    }
}
