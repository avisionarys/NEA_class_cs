//
//  templateViewController.swift
//  NEA
//
//  Created by CHETAN VISROLIA on 09/02/2025.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseDatabase




class templateViewController: UIViewController, UITableViewDelegate , MyProtocol, customCellDelegate{
    
    
    
    private let db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    
    var weightText: String?
    var repsText: String?
    
    
    var Workouts: [String] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segues" {
            if let secondVC = segue.destination as? exercisesViewController {
                secondVC.delegate = self
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTableView.dataSource = self
        exerciseTableView.delegate = self
        
        tableView.register(UINib(nibName: "TemplateTableViewCell" , bundle: nil), forCellReuseIdentifier: "cellReused")
        
    }
    
    
    @IBOutlet weak var exerciseTableView: UITableView!
  
    func addExercise(workout: String){
        Workouts.append(workout)
        exerciseTableView.reloadData()
    }
    
    
    func didUpdateText(_ cell: TemplateTableViewCell, weight: String, reps: String) {
        weightText = weight
        repsText = reps
            
        
    }
    
    
    
   
    
    func saveWorkout(weight:String, reps: String){
        if let user = Auth.auth().currentUser {
            let userID = user.uid
            let workoutID  = UUID().uuidString
            let workoutData: [String: Any] = [
                "weight" : weight,
                "reps" : reps
            ]
                
                
            self.db.collection("userdata").document(userID).collection(workoutID).addDocument(data:workoutData){ error in
                if let error = error {
                    print("Error saving workout data: \(error)")
                } else {
                    print("Workout data saved successfully!")
                }
            }
        
        }else {
            print("No user is signed in.")
        }
    }
  
    @IBAction func finishedPressed(_ sender: UIBarButtonItem) {
        guard let weight = weightText else {return}
        guard let reps = repsText else {return}
        saveWorkout(weight: weight, reps: reps)
        dismiss(animated: true)
  
    }
    

}
    
extension templateViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return Workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReused", for: indexPath) as!  TemplateTableViewCell
        cell.nameOfExercise.text = Workouts[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}



    

