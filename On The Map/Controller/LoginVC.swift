//
//  LoginVC.swift
//  On The Map
//
//  Created by Pierre Younes on 3/8/21.
//

import UIKit

class LoginVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        txtEmail.delegate = self
        txtPassword.delegate = self
    }
    
    // MARK: - Actions
    private func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            performSegue(withIdentifier: "MapVC", sender: nil)
        } else {
            if let error = error as? UdacityFailure {
                showAlert(message: error.localizedDescription, title: "Validation Error")
            } else {
                showAlert(message: error!.localizedDescription, title: "Connection Error")
            }
        }
    }
    
    
    // IBActions
    @IBAction func loginClicked(_ sender: Any) {
        
        if let email = self.txtEmail.text, let password = self.txtPassword.text {
            if !email.isEmpty && !password.isEmpty {
                let user = Udacity(udacity: Credentials(username: email, password: password))
                showSpinnerView()
                UserServices.shared.login(logins: user, completion: handleLoginResponse(success:error:))
            } else {
                showAlert(message: "Username & Password cannot be blank", title: "Attention")
            }
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        UIApplication.shared.open(URL(string: GConstants.WebURL.udacitySignUp)!)
    }
}

// MARK: UITextfield Delegate
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
