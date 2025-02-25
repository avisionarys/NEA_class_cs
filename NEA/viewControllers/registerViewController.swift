//
//  registerViewController.swift
//  NEA
//
//  Created by CHETAN VISROLIA on 24/01/2025.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseDatabase

class registerviewcontroller: UIViewController {
    
    private let db = Firestore.firestore()
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        func checkEmailValidity(email: String) -> Bool {
            let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
            return emailPredicate.evaluate(with: email)
        }
        
        if let email = emailTextField.text, let name = nameTextField.text, let surname = surnameTextField.text, let age = ageTextField.text, let weight = weightTextField.text, let height = heightTextField.text, let password = passwordTextField.text {
            let userID = UUID().uuidString
            if checkEmailValidity(email: email) {
                Auth.auth().createUser(withEmail: email, password: password) {authResult,error in
                    if let error = error{
                        print(error)
                    }else {
                        
                        self.db.collection("users").document(userID).setData([
                            "name": name,
                            "surname": surname,
                            "email": email,
                            "password": password,
                            "age": age,
                            "weight": weight,
                            "height": height
                            
                        ])
                    }
                    if let error = error {
                        print("Error saving data to Firestore: \(error.localizedDescription)")
                    } else {
                        print("Data successfully saved to Firestore.")
                        self.performSegue(withIdentifier: "reghomeViewController", sender: self)
                    }
                }
                
            }
            
            
        }
    }
    
}
